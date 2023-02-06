import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

//import '../controllers/bloc/app_cubit.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color darkBlue = Color(0xFF192882);
const Color lightBlue = Color(0xFFbddbff);


 class Themes {


  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: darkHeaderClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );


  static TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.white : Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ));
  }
  static TextStyle get supHeadingStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }
  static TextStyle get titleStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.white : Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ));
  }
  static TextStyle get supTitleStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ));
  }

  static TextStyle get bodyStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ));
  }

  static TextStyle get body2Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
          //color: !cubit.moodl ? Colors.grey[200] : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ));
  }
}
