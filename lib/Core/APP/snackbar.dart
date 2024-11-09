



import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'Utils.dart';

enum SnackBarType{
  textSnackBar,
  widgetSnackBar;
}

class SnackBarManager{

  static final Queue<List<Object>> _snackBars = Queue<List<Object>>();
  static bool _snackBarIsShowingUp = false;
  static String _currentlyShowingUp = "";


  static addNewTextSnackBar(BuildContext context,{required String text, TextStyle? textStyle, TextAlign textAlign = TextAlign.center,Duration duration = const Duration(milliseconds: 500)}){
    textStyle == null ? textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white) : textStyle = textStyle;

    duration = Utils.getDebugging() ? const Duration(seconds: 3) : duration;

    if(_currentlyShowingUp == text){
      return;
    }

    //too many, duplication guard
    if(_snackBars.isNotEmpty){
      for (List<Object> element in _snackBars) {
        if((element[0] as String) == text){
          return;
        }
      }
    }


    _snackBars.addFirst([text ,SnackBarType.textSnackBar, context, textStyle as Object,textAlign, duration as Object]);


    if(_snackBars.isNotEmpty){
      _showNextSnackBar();
    }


  }


  static _showNextSnackBar() {

    List<Object> snack = _snackBars.removeLast();
    _snackBarIsShowingUp = true;
    if(snack[1] == SnackBarType.textSnackBar){
      _currentlyShowingUp = snack[0] as String;
      _showTextSnackBar(snack[2] as BuildContext,text: snack[0] as String, textStyle: snack[3] as TextStyle, textAlign: snack[4] as TextAlign,duration:snack[5] as Duration);
    }

  }


  static _showTextSnackBar(BuildContext context,{required String text, TextStyle? textStyle, TextAlign textAlign = TextAlign.center, required Duration duration}) {
    _shouldDismissKeyboard(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
          duration: duration,
          content: Text(
            text,
            style: textStyle,
            textAlign: textAlign,
          ),
        )).closed.then((value) {
      _snackBarIsShowingUp = false;
      _currentlyShowingUp = "";
    });
  }


  static _shouldDismissKeyboard(BuildContext context){
    if(Platform.isAndroid || Platform.isIOS){
      Utils.dismissKeyboard(context);
    }
  }

}
