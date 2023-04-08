import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Themes {
  //app colors declared here
  static const Color bgDarkScaffold = Color(0xff454545);
  static const Color blackColor = Color(0xff000000);
  static const Color whiteColor = Color(0xffffffff);
  static const Color mainColor = Color(0xff035CA3);
  static const Color cardOne = Color(0xff5DD6F4);
  static const Color cardTwo = Color(0xff525252);
  static const Color cardThree = Color(0xff024376);
  //this is my light theme colors
  static final light = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: mainColor,
          onPrimary: whiteColor,
          secondary: whiteColor,
          onSecondary: blackColor,
          background: whiteColor,
          onBackground: blackColor,
          surface: whiteColor,
          onSurface: blackColor,
          error: Colors.redAccent,
          onError: Colors.red,));
  //this is my dark theme colors
  static final dark = ThemeData(
      colorScheme: ColorScheme(
          background: bgDarkScaffold,
          onBackground: Colors.grey.shade400,
          brightness: Brightness.dark,
          primary: blackColor,
          onPrimary: whiteColor,
          secondary: Colors.black38,
          onSecondary: Colors.grey,
          error: Colors.redAccent,
          onError: Colors.redAccent,
          surface: blackColor,
          onSurface: whiteColor));
}

//public methods defined below within a file and it can be called anywhere in the project
//below are the text styles
//define a get function to return something

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold, 
          color: Get.isDarkMode ? Themes.whiteColor : Themes.blackColor));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Themes.whiteColor : Themes.blackColor));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Get.isDarkMode ? Themes.whiteColor : Themes.blackColor));
}

TextStyle get inputTextStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700]));
}
