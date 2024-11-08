import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Utils.dart';
import 'colors.dart';



class AppTheme{

  static TextStyle? labelMedium;


  static TextStyle fontBuilder(BuildContext context){
    if(Utils.getCurrentLocal(context).contains('ar')){
      return GoogleFonts.tajawal(
        color:  MyColors.c2,
        fontSize: Utils.fontConstraints(MediaQuery.of(context).size.width * 0.05),
        fontWeight: FontWeight.w500,
      );
    }
    else{
      return GoogleFonts.poppins(
        color:  MyColors.c2,
        fontSize: Utils.fontConstraints(MediaQuery.of(context).size.width * 0.04),
      );
    }
  }


  static ThemeData buildAppTheme(BuildContext context){

    TextStyle datePickerRelated = Utils.getCurrentLocal(context).contains('ar') ? GoogleFonts.tajawal(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ) : GoogleFonts.pottaOne(fontWeight: FontWeight.bold,);
    WidgetStateTextStyle datePickerButtonsRelated = WidgetStateTextStyle.resolveWith((states) => fontBuilder(context).copyWith(fontWeight: FontWeight.bold));



    labelMedium = Utils.getCurrentLocal(context).contains('ar') ?
    fontBuilder(context).copyWith(
      color:  MyColors.c2,
      fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.025),
      fontWeight: FontWeight.w500,
    ) :
    fontBuilder(context).copyWith(
      color:  MyColors.c2,
      fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.025),
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: MyColors.c3),
      primaryColor:  MyColors.c3,
      textTheme: TextTheme(
        titleLarge: Utils.getCurrentLocal(context).contains('ar') ?
        fontBuilder(context).copyWith(
          color: Colors.white,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.03),
          fontWeight: FontWeight.w900,
        ) :
        fontBuilder(context).copyWith(
          color: MyColors.c2,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.027),
          fontWeight: FontWeight.w800,
        ),
        labelMedium: labelMedium,
        labelSmall: Utils.getCurrentLocal(context).contains('ar') ?
        fontBuilder(context).copyWith(
          color:  MyColors.c2,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.023),
          fontWeight: FontWeight.w300,
        ) :
        fontBuilder(context).copyWith(
          color:  MyColors.c2,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.017),
          fontWeight: FontWeight.w300,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MyColors.c1,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => MyColors.c3),
            maximumSize: WidgetStateProperty.resolveWith((states) => Size(MediaQuery.of(context).size.width * 0.8,100)),
            minimumSize: WidgetStateProperty.resolveWith((states) => Size(MediaQuery.of(context).size.width * 0.3,40)),
          )
      ),
      iconTheme: IconThemeData(
        color: MyColors.c2,
        size: 48,
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: MyColors.c2,
        prefixIconColor: MyColors.c2,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Utils.getCurrentLocal(context).contains('ar') ?
        GoogleFonts.tajawal(
          color: Colors.red,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.016),
          fontWeight: FontWeight.w300,
        ) :
        GoogleFonts.pottaOne(
          color: Colors.red,
          fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.0115),
          fontWeight: FontWeight.w300,
        ),
        labelStyle: TextStyle(
          color: MyColors.c2,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
      datePickerTheme: DatePickerThemeData(
          confirmButtonStyle: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
            textStyle: datePickerButtonsRelated,
          ),
          cancelButtonStyle: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
            textStyle: datePickerButtonsRelated,
          ),


          dayStyle: datePickerRelated,
          weekdayStyle: datePickerRelated,
          yearStyle: datePickerRelated,
          headerHeadlineStyle: datePickerRelated,
          headerHelpStyle: datePickerRelated,
          inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: MyColors.c2,
            prefixIconColor: MyColors.c2,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            errorStyle: Utils.getCurrentLocal(context).contains('ar') ?
            GoogleFonts.tajawal(
              color: Colors.red,
              fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.016),
              fontWeight: FontWeight.w300,
            ) :
            GoogleFonts.pottaOne(
              color: Colors.red,
              fontSize: Utils.fontConstraints(MediaQuery.of(context).size.height * 0.0115),
              fontWeight: FontWeight.w300,
            ),
            errorMaxLines: 5,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: MyColors.c3),
              borderRadius: BorderRadius.circular(15),
            ),
            labelStyle: TextStyle(
              color: MyColors.c2,
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          rangePickerHeaderHeadlineStyle: datePickerRelated,
          rangePickerHeaderHelpStyle: datePickerRelated,
          rangePickerHeaderForegroundColor: Colors.white,
          rangePickerHeaderBackgroundColor:Colors.grey
      ),
      checkboxTheme: CheckboxThemeData(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          side: BorderSide(
              color: MyColors.c3
          )
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => MyColors.c1),
        interactive: true,
        radius: const Radius.circular(10),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) => MyColors.c3),
            maximumSize: WidgetStateProperty.resolveWith((states) => Size(MediaQuery.of(context).size.width * 0.8,100)),
            minimumSize: WidgetStateProperty.resolveWith((states) => Size(MediaQuery.of(context).size.width * 0.3,40)),
            side: WidgetStateProperty.resolveWith((states) => BorderSide(width: 1.5, color: MyColors.c2),),
            iconColor: WidgetStateProperty.resolveWith((states) => MyColors.c2),
            iconSize: WidgetStateProperty.resolveWith((states) => MediaQuery.of(context).size.height * 0.045,),
          ),
          selectedIcon: const Icon(Icons.check,color: Colors.white,)
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: Utils.getCurrentLocal(context).contains('ar') ?
        GoogleFonts.tajawal(
          color: MyColors.c2,
          fontSize: MediaQuery.of(context).size.height * 0.023,
          fontWeight: FontWeight.w500,
        ) :
        GoogleFonts.pottaOne(
          color: MyColors.c2,
          fontSize: MediaQuery.of(context).size.height * 0.017,
          fontWeight: FontWeight.w300,),
        menuStyle: MenuStyle(
            shape: WidgetStateProperty.resolveWith((states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),)
        ),
      ),
      useMaterial3: true,
    );
  }

}