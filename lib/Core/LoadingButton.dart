import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';




class LoadingButton extends StatefulWidget {
  final Function() onPressed;
  final String? buttonText;
  final Widget? buttonIcon;
  final TextStyle? buttonTextStyle;
  final ButtonStyle buttonStyle;

  const LoadingButton({super.key, required this.onPressed, this.buttonText, required this.buttonStyle, this.buttonTextStyle, this.buttonIcon}) : assert(buttonText != null || buttonIcon != null);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {

  final ValueNotifier<bool> _startingChat = ValueNotifier<bool>(false);



  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.milliseconds,
      child: ValueListenableBuilder(
        valueListenable: _startingChat,
        builder: (BuildContext context, value, builderWidget) {
          return AnimatedSwitcher(
              duration: 500.milliseconds,
              child: value ?
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ) :
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextButton(

                    onPressed: () async {
                      _startingChat.value = !_startingChat.value;
                      //print("pre");
                      await widget.onPressed();
                      //print("done");
                      _startingChat.value = !_startingChat.value;
                    },
                    style: widget.buttonStyle,
                    child: widget.buttonText != null ?
                    Text(
                      widget.buttonText!,
                      style: widget.buttonTextStyle ?? Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.right,
                    ) :
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: widget.buttonIcon!,
                    )
                ),
              )
          );
        },
      ),
    );
  }
}
