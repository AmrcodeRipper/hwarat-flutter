





import 'dart:ui';
import 'package:flutter/material.dart';


class APP{

  static String localAPIServerIP = 'http://192.168.0.26:3500';
  static String globalAPIServerIP = 'https://hwarat-backend.onrender.com/';

  static bool debugging = false;

  static Locale arabic = const Locale('ar');
  static Locale english = const Locale('en');

  static Locale lang = arabic;


  static DateTime currentDateAndTime = DateTime(APP.year,APP.month,APP.day,DateTime.now().hour,DateTime.now().minute,DateTime.now().second);
  static int year = DateTime.now().year;
  static int month = DateTime.now().month;
  static int day = DateTime.now().day;



  static DesignDimensions designSize = DesignDimensions();

  static const maxCharactersForTextField = 100;
  static const double myBalance = 0.0;
  static String openToken = "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";

  static String? threadID;

  //0 means hwarat default
  //1 means allam plus
  static int selectedRadio = 2;

  static String? iBMToken = '';

}


class DesignDimensions{

  Size small = const Size(430, 932);
  Size large = const Size(1440, 960);

  DesignDimensions();
}