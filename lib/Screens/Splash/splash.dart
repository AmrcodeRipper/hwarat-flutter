

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/APP/colors.dart';






class NewSplash extends StatefulWidget {
  final bool showLogo;

  const NewSplash({super.key, this.showLogo = true});

  @override
  State<NewSplash> createState() => _NewSplashState();
}

class _NewSplashState extends State<NewSplash> {


  final Duration _backgroundAnimationDuration = 500.milliseconds;

  final Duration _circlesMovingAnimationDuration = 500.milliseconds;
  final Duration _circlesOpacityAnimationDuration = 1.seconds;

  final Curve _circlesCurve = Curves.linear;

  //false means we are at beginning and true means at ending
  bool _animationState = false;
  bool _isNotAnimatingMovement = true;

  //keep changing opacity and consider it as circular loading
  bool _isLoading = true;

  final Gradient _defaultGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF00FAF6).withOpacity(0.2),
        Color(0xFF2838BF).withOpacity(0.3),
      ]);
  final Gradient _coloredCirclesGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        MyColors.c1,
        MyColors.c1,
      ]);

  final Gradient _whiteGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Colors.white,
      ]);

  Color? textColor;
  Color? brainColor;
  Color? aiTextColor;


  //Colors and Positions Configuration
  double circlesOpacity = 1.0;

  Gradient? _mainPageGradient;
  Gradient? _circlesGradient;

  Alignment? _firstCircleA;
  double? _firstCircleW;
  double? _firstCircleH;

  Alignment? _secondCircleA;
  double? _secondCircleW;
  double? _secondCircleH;

  Alignment? _thirdCircleA;
  double? _thirdCircleW;
  double? _thirdCircleH;

  Alignment? _fourthCircleA;
  double? _fourthCircleW;
  double? _fourthCircleH;

  Alignment? _fifthCircleA;
  double? _fifthCircleW;
  double? _fifthCircleH;

  Alignment? _sixthCircleA;
  double? _sixthCircleW;
  double? _sixthCircleH;

  Alignment? _seventhCircleA;
  double? _seventhCircleW;
  double? _seventhCircleH;

  Alignment? _eighthCircleA;
  double? _eighthCircleW;
  double? _eighthCircleH;

  Alignment? _ninthCircleA;
  double? _ninthCircleW;
  double? _ninthCircleH;

  Alignment? _tenthCircleA;
  double? _tenthCircleW;
  double? _tenthCircleH;

  Alignment? _eleventhCircleA;
  double? _eleventhCircleW;
  double? _eleventhCircleH;
  //End of Colors and Position Configuration



  void beginningConfiguration(){
    _mainPageGradient = _defaultGradient;
    _circlesGradient = _whiteGradient;

    textColor = const Color(0xFF00D8C7);
    brainColor = const Color(0xFF00D8C7);
    aiTextColor = Colors.white;

    _firstCircleA = const Alignment(0.8, -0.9);
    _firstCircleW = 45;
    _firstCircleH = 45;

    _secondCircleA = const Alignment(-0.5, -1.0);
    _secondCircleW = 20;
    _secondCircleH = 20;

    _thirdCircleA = const Alignment(-0.1, -0.6);
    _thirdCircleW = 20;
    _thirdCircleH = 20;

    _fourthCircleA = const Alignment(-0.8, -0.4);
    _fourthCircleW = 20;
    _fourthCircleH = 20;

    _fifthCircleA = const Alignment(-0.8, 0.4);
    _fifthCircleW = 30;
    _fifthCircleH = 30;

    _sixthCircleA = const Alignment(1.15, 0.6);
    _sixthCircleW = 50;
    _sixthCircleH = 50;


    _seventhCircleA = const Alignment(1.2, -0.35);
    _seventhCircleW = 40;
    _seventhCircleH = 40;


    _eighthCircleA = const Alignment(1.2, 0.1);
    _eighthCircleW = 20;
    _eighthCircleH = 20;


    _ninthCircleA = const Alignment(-1.2, 0.3);
    _ninthCircleW = 25;
    _ninthCircleH = 25;


    _tenthCircleA = const Alignment(-1.2, 0);
    _tenthCircleW = 25;
    _tenthCircleH = 25;


    _eleventhCircleA = const Alignment(-1.2, -0.2);
    _eleventhCircleW = 25;
    _eleventhCircleH = 25;
  }

  void endingConfiguration(){
    _mainPageGradient = _whiteGradient;
    _circlesGradient = _coloredCirclesGradient;

    textColor = Colors.white;
    brainColor = Colors.white;
    aiTextColor = const Color(0xFF00D8C7);

    _firstCircleA = const Alignment(0.5, -0.6);
    _firstCircleW = 25;
    _firstCircleH = 25;


    _secondCircleA = const Alignment(-0.35, -0.7);
    _secondCircleW = 15;
    _secondCircleH = 15;


    _thirdCircleA = const Alignment(0, -0.5);
    _thirdCircleW = 10;
    _thirdCircleH = 10;


    _fourthCircleA = const Alignment(-0.6, -0.3);
    _fourthCircleW = 10;
    _fourthCircleH = 10;

    _fifthCircleA = const Alignment(-0.5, 0.25);
    _fifthCircleW = 15;
    _fifthCircleH = 15;

    _sixthCircleA = const Alignment(0.75, 0.4);
    _sixthCircleW = 30;
    _sixthCircleH = 30;

    _seventhCircleA = const Alignment(0.8, -0.2);
    _seventhCircleW = 35;
    _seventhCircleH = 35;


    _eighthCircleA = const Alignment(0.8, 0.1);
    _eighthCircleW = 12;
    _eighthCircleH = 12;


    _ninthCircleA = const Alignment(-0.8, 0.1);
    _ninthCircleW = 25;
    _ninthCircleH = 25;

    _tenthCircleA = const Alignment(-0.7, -0.07);
    _tenthCircleW = 10;
    _tenthCircleH = 10;

    _eleventhCircleA = const Alignment(-0.8, -0.2);
    _eleventhCircleW = 20;
    _eleventhCircleH = 20;
  }

  Future<void> animateOpacity() async {
    if(_isLoading){
      if(mounted){
        setState(() {
          circlesOpacity = circlesOpacity != 0.3 ? 0.3 : 1;
        });
      }
    }
  }

  void startOpacityAnimationAfterMovingAnimation(){
    Future.delayed(_circlesMovingAnimationDuration,(){
      _isLoading = true;
      animateOpacity();
    });
  }

  void cancelOpacityAnimation(){
    _isLoading = false;
    if(mounted){
      if(circlesOpacity != 1.0){
        setState(() {
          circlesOpacity = 1.0;
        });
      }
    }
  }

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }

  @override
  void initState() {
    beginningConfiguration();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //In case keyboard was open for some reason
      FocusScope.of(context).requestFocus(FocusNode());

      Future.delayed(700.milliseconds,(){
        toggleAnimation();

        Future.delayed(4.seconds,(){
          context.pushReplacement('/chatting');
        });

      });

    });
  }

  void toggleAnimation(){
    if(!widget.showLogo){
      return;
    }

    if(_isNotAnimatingMovement){
      _isNotAnimatingMovement = false;
      if(_animationState){
        cancelOpacityAnimation();
        setState(() {
          beginningConfiguration();
        });
      }
      else{
        setState(() {
          endingConfiguration();
        });
        startOpacityAnimationAfterMovingAnimation();
      }
      _animationState = !_animationState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //toggleAnimation();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedContainer(
          duration: _backgroundAnimationDuration,
          curve: Curves.easeIn,
          decoration: BoxDecoration(
              gradient: _mainPageGradient
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: 400,
                height: 700,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Image.asset("assets/images/hwarat-logo.png",fit: BoxFit.scaleDown, width: 200, height: 200,),
                    ),
                    widget.showLogo ?
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      onEnd: (){
                        animateOpacity();
                      },
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        onEnd: (){
                          _isNotAnimatingMovement = true;
                        },
                        alignment: _firstCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _firstCircleW,
                            height: _firstCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ) : const SizedBox(),
                    widget.showLogo ?
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _secondCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _secondCircleW,
                            height: _secondCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ) : const SizedBox(),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _thirdCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _thirdCircleW,
                            height: _thirdCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _fourthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _fourthCircleW,
                            height: _fourthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _fifthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _fifthCircleW,
                            height: _fifthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _sixthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _sixthCircleW,
                            height: _sixthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),

                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _seventhCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _seventhCircleW,
                            height: _seventhCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _eighthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _eighthCircleW,
                            height: _eighthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _ninthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _ninthCircleW,
                            height: _ninthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _tenthCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _tenthCircleW,
                            height: _tenthCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: circlesOpacity,
                      duration: _circlesOpacityAnimationDuration,
                      child: AnimatedContainer(
                        duration: _circlesMovingAnimationDuration,
                        curve: _circlesCurve,
                        alignment: _eleventhCircleA,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width: _eleventhCircleW,
                            height: _eleventhCircleH,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: _circlesGradient,
                            ),
                          ),
                        ),
                      ),
                    ),

                    widget.showLogo ?
                    Align(
                        alignment: const Alignment(0.0, 0.7),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                              width: 200,
                              child: Hero(
                                  tag: "name",
                                  child: Image.asset("assets/images/hwarat-text.png",fit: BoxFit.scaleDown, width: 300, height: 100,))
                          ),
                        )) : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

