import 'package:bottoms_up/design/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppText {
  //Splash Screen
  static TextStyle get splashText {
    return TextStyle(
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(10.0, 5.0),
          blurRadius: 3.0,
          color: Color(0xFFfe8238),
        ),
      ],
    );
  }

  //bottomsUp splashFont
  static TextStyle get splashFont {
    return GoogleFonts.shrikhand(
      fontWeight: FontWeight.bold,
      fontSize: 60.0,
      textStyle: splashText,
    );
  }

  //Shadows for truth Or Dare Game Title
  static List<Shadow> get truthDareShadow {
    return <Shadow>[
      Shadow(
        offset: Offset(5.0, 5.0),
        blurRadius: 3.0,
        color: Color(0xFFfa7650),
      ),
      Shadow(
        offset: Offset(8.0, 8.0),
        blurRadius: 5.0,
        color: Color(0xFFf48c4d),
      ),
    ];
  }

  //TruthDare Game Tile Text
  static TextStyle truthTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontFamily: 'Gagalin',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  static TextStyle orTextStyle({MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontFamily: 'Bukhari',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  static TextStyle dareTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontFamily: 'Gagalin',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  //Styles of the card texts truth or dare game
  static TextStyle tDcurrentCardTypeTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        color: AppColors.tDgradientRed,
        fontFamily: "Bukhari",
        fontSize: 40,
      );

  static TextStyle tDcurrentQuestionTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontFamily: "Oswald",
        fontSize: 25.0,
      );

  static TextStyle tDcurrentGameTypeTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontSize: 14.0,
        fontFamily: "Bukhari",
        letterSpacing: 1.5,
        color: AppColors.tDgradientRed,
      );

  //Heads Or Tails Text
  static headsTailsTitleText({String text, double size}) => Text(
        text,
        style: headsTailsTitleTextStyle(fontSize: size, isQuestionType: false),
      );

  static TextStyle headsTailsTitleTextStyle(
          {double fontSize, @required bool isQuestionType}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: 'Bungee',
        color: isQuestionType ? Color(0xFFffbd59) : Color(0xFF7943e6),
        shadows: <Shadow>[
          Shadow(
            offset: Offset(1.7, -0.8),
            color: Color(0xFF02feff),
          ),
          Shadow(
            offset: Offset(-1.4, 1.5),
            color: Color(0Xffff25ff).withOpacity(0.8),
          ),
        ],
      );

  static TextStyle headTailsCoinTextStyle(
          {MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontFamily: 'Gagalin',
        color: Color(0xFF7943e6),
        fontSize: fontSize,
      );

  //Kings Cup Text
  static TextStyle kingsCupTextStyle() => TextStyle(
        fontSize: 60.0,
        fontFamily: "Monoton",
        height: 1,
        color: Colors.white,
      );
}
