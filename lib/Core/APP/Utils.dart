import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'config.dart';



class Utils{

  //API Utils
  static String failedToGetMessageFromAPI = "API_Errors".tr(gender: "1009");
  static String ableToGetMessageFromAPI = "API_Errors".tr(gender: "200_lo");

  static String responseAnalyzer(int statusCode){
    switch(statusCode){
    //Server errors
      case 200:
        return "API_Errors".tr(gender: '200');
      case 400:
        return "API_Errors".tr(gender: '400');
      case 401:
        return "API_Errors".tr(gender: '401');
      case 403:
        return "API_Errors".tr(gender: '403');
      case 404:
        return "API_Errors".tr(gender: '404');
      case 409:
        return "API_Errors".tr(gender: '409');
      case 500:
        return "API_Errors".tr(gender: '500');
      case 509:
        return "API_Errors".tr(gender: '509');
    //Internal client errors
      case -2:
        return "API_Errors".tr(gender: '-2');
      case -3:
        return "API_Errors".tr(gender: '-3');
    //Dio EXCEPTIONS
      case -101:
        return "API_Errors".tr(gender: '-101');
      case -102:
        return "API_Errors".tr(gender: '-102');
      case -103:
        return "API_Errors".tr(gender: '-103');
      case -104:
        return "API_Errors".tr(gender: '-104');
      case -105:
        return "API_Errors".tr(gender: '-105');
      case -106:
        return "API_Errors".tr(gender: '-106');
      case -107:
        return "API_Errors".tr(gender: '-107');
      case -108:
        return "API_Errors".tr(gender: '-108');
      default:
        if (kDebugMode) {
          print(statusCode);
        }
        return "API_Errors".tr(gender: 'def');
    }
  }

  static MapEntry<String,dynamic> getDefaultHeader(){
    return MapEntry('Authorization', 'Bearer ${APP.openToken}');
  }

  static MapEntry<String,dynamic> openAIBetaHeader(){
    return const MapEntry('OpenAI-Beta', 'assistants=v2');
  }

  static String parseErrorAPIMessage(Response? res){
    String apiResponseError = failedToGetMessageFromAPI;
    try{
      apiResponseError = jsonDecode(res.toString())[APP.lang == APP.arabic ? "arMessage" : "enMessage"];
    }
    catch(e){
      return apiResponseError;
    }
    return apiResponseError;
  }

  static String parseSuccessAPIMessage(Response? res){
    String apiResponseError = ableToGetMessageFromAPI;
    try{
      apiResponseError = jsonDecode(res.toString())[APP.lang == APP.arabic ? "ar" : "en"];
    }
    catch(e){
      return apiResponseError;
    }
    return apiResponseError;
  }


  //UI Responsive Utils
  static bool shortScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width < 400 ? true : false;
  }

  static bool shortScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height < 700 ? true : false;
  }

  static double fontConstraints(double inFont){
    return clampDouble(inFont, 10, 20);
  }


  //UI Unified decorations

  static BoxDecoration getDefaultContainersDecoration({Color mainColor = Colors.white, BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(20)), Color boxShadowColor = const Color(0xFF8E8FFA), double spreadRadius = 0.5, double offsetX = 2.5, double offsetY = 1.5, double blurRadius = 2.5,}){
    return BoxDecoration(
        borderRadius: borderRadius,
        color: mainColor,
        boxShadow: [
          BoxShadow(
              color: boxShadowColor,
              spreadRadius: spreadRadius,
              offset: Offset(offsetX, offsetY),
              blurRadius: blurRadius)
        ]);
  }

  static BoxDecoration getStyle1ContainersDecoration(){
    return Utils.getDefaultContainersDecoration(spreadRadius: 1,offsetX: 7,offsetY: 5,blurRadius: 10);
  }

  static BoxDecoration getStyle2ContainersDecoration(){
    return Utils.getDefaultContainersDecoration(spreadRadius: 1,offsetX: 3.5,offsetY: 2.5,blurRadius: 5);
  }


  //UI Utils

  static figmaToMobileMeasure(double input){
    return (input/(440/160));
  }


  static String getCurrentLocal(BuildContext context){
    return context.locale.toString();
  }

  static material.TextDirection getTextDirection(BuildContext context){
    return getCurrentLocal(context).contains('ar') ? material.TextDirection.rtl : material.TextDirection.ltr;
  }

  static void changeLanguage(BuildContext context){
    context.push('/lang');
  }

  static void dismissKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool getDebugging(){
    return APP.debugging;
  }

  static ButtonStyle getDefaultButtonStyle(BuildContext context){
    return ButtonStyle(
      fixedSize: WidgetStateProperty.resolveWith(
              (states) =>
          const Size(
              50,
              25)),
      maximumSize: WidgetStateProperty.resolveWith((states) => Size(clampDouble(MediaQuery.of(context).size.width * 0.8, 20, 50), 50)),
      minimumSize: WidgetStateProperty
          .resolveWith((states) => Size(
          clampDouble(
              MediaQuery.of(context)
                  .size
                  .width *
                  0.8,
              20,
              40),
          50)),
    );
  }

  static ButtonStyle getOptionsButtonStyle(BuildContext context){
    return ButtonStyle(
      fixedSize: WidgetStateProperty.resolveWith((states) => const Size(300, 50)),
      maximumSize: WidgetStateProperty.resolveWith((states) => Size(clampDouble(MediaQuery.of(context).size.width * 0.8, 20, 300), 50)),
      minimumSize: WidgetStateProperty.resolveWith((states) => Size(clampDouble(MediaQuery.of(context).size.width * 0.8, 20, 100),50)),
    );
  }



  //System Permissions
  static bool validPermission(String role){
    return role == "NORMAL" || role == "COMPANY" || role == "COMPANY_MEMBER" || adminPermission(role);
  }

  static bool normalPermission(String role){
    return role == "NORMAL" || role == "COMPANY" || role == "COMPANY_MEMBER";
  }

  static bool noMembersPermission(String role){
    return role == "NORMAL" || role == "COMPANY";
  }

  static bool noMembersPermissionPlusAdmin(String role){
    return role == "NORMAL" || role == "COMPANY" || adminPermission(role);
  }

  static bool noMembersNoNormalPermission(String role){
    return adminPermission(role) || role == "COMPANY";
  }

  static bool companyPermission(String role){
    return role == "COMPANY";
  }

  static bool adminPermission(String role){
    return base64Encode(base64Encode(role.codeUnits).codeUnits) == "UVVSTlNVND0=";
  }



  //Data Utils
  static String formatNumberToGroupBy4(String number) {
    // Remove any existing dashes
    number = number.replaceAll('-', '');

    // Split the number into groups of four
    List<String> groups = [];
    for (int i = 0; i < number.length; i += 4) {
      groups.add(number.substring(i, i + 4 > number.length ? number.length : i + 4));
    }

    // Join the groups with dashes
    return groups.join('-');
  }

  static String fixClosures(String input) {
    List<String> stack = [];
    StringBuffer output = StringBuffer(input);

    for (int i = 0; i < input.length; i++) {
      if (input[i] == '{' || input[i] == '[') {
        stack.add(input[i]);
      } else if (input[i] == '}' || input[i] == ']') {
        if (stack.isNotEmpty && (
            (input[i] == '}' && stack.last == '{') ||
                (input[i] == ']' && stack.last == '['))) {
          stack.removeLast();
        }
      }
    }

    while (stack.isNotEmpty) {
      String last = stack.removeLast();
      if (last == '{') {
        output.write('}');
      } else if (last == '[') {
        output.write(']');
      }
    }

    return output.toString();
  }


}
