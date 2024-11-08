





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