import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'Core/APP/theme.dart';
import 'Screens/Chatting/chat_new.dart';
import 'Screens/Splash/splash.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: const [Locale('ar'),Locale('en')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('ar'),
        child: const MyApp()
    )
  );
}



final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NewSplash(),
    ),
    GoRoute(
      path: '/chatting',
      //builder: (context, state) => const ChattingNew(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ChattingNew(title: "ياسر الحزيمي",),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              scale: CurveTween(curve: Curves.easeIn).animate(animation,),
              child: child,
            );
          },
        );
      },
    ),
  ],
);



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'حوارات',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.buildAppTheme(context),
      routerConfig: _router,
    );
  }
}

