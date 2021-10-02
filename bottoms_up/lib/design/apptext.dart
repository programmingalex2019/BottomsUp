import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppText {

  static String get truthDareDescription => " but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String get headsTailsDescription => " but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String get kingsCupDescription => " but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

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
  static TextStyle truthTextStyle({double fontSize}) =>
      TextStyle(
        fontFamily: 'Gagalin',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  static TextStyle orTextStyle({double fontSize}) =>
      TextStyle(
        fontFamily: 'Bukhari',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  static TextStyle dareTextStyle({double fontSize}) =>
      TextStyle(
        fontFamily: 'Gagalin',
        color: Colors.white,
        fontSize: fontSize,
        shadows: AppText.truthDareShadow,
      );

  //Styles of the card texts truth or dare game
  static TextStyle tDcurrentCardTypeTextStyle({BuildContext context}) {

    SizeConfig().init(context);

    return TextStyle(
      color: AppColors.tDgradientRed,
      fontFamily: "Bukhari",
      fontSize: SizeConfig.safeBlockHorizontal * 10,
    );
  }

  static TextStyle tDcurrentQuestionTextStyle({BuildContext context}) {

    SizeConfig().init(context);

    return TextStyle(
      fontFamily: "Oswald",
      fontSize: SizeConfig.safeBlockHorizontal * 6.5,
    );
  }

  static TextStyle tDcurrentGameTypeTextStyle({BuildContext context}) {

    SizeConfig().init(context);
    
    return TextStyle(
      fontSize: SizeConfig.safeBlockHorizontal * 5,
      fontFamily: "Bukhari",
      letterSpacing: 1.5,
      color: AppColors.tDgradientRed,
    );
  }

  //Heads Or Tails Text
  static headsTailsTitleText({String text, double size}) => Text(
        text,
        style: headsTailsTitleTextStyle(fontSize: size),
      );

  static TextStyle headsTailsTitleTextStyle({double fontSize}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: 'Bungee',
        color: Color(0xFF7943e6),
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

  static TextStyle headsTailsCardTextStyle({double fontSize, Color color}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: 'Bungee',
        color: color,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(1, 1),
            color: Colors.black.withOpacity(0.8),
          ),
        ],
      );

  static TextStyle headsTailsCardTextStyleContent({double fontSize, Color color}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: 'Oswald',
        letterSpacing: 1.5,
        color: color,
        shadows: <Shadow>[
          // Shadow(
          //   offset: Offset(1, 1),
          //   color: Colors.black.withOpacity(0.8),
          // ),
        ],
      );  

  static TextStyle headTailsCoinTextStyle({MediaQueryData mediaQuery, double fontSize}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: 'Bungee',
        color: Color(0xFF7943e6),
        shadows: <Shadow>[
          Shadow(
            offset: Offset(-1.4, 1.5),
            color: Color(0Xffff25ff).withOpacity(0.8),
            blurRadius: 2,
          ),
          Shadow(
            offset: Offset(-1.4, 1.5),
            color: Color(0Xffff25ff).withOpacity(0.8),
          ),
        ],
      );



  //Kings Cup Text
  static TextStyle kingsCupTextStyle({BuildContext context}) {

    SizeConfig().init(context);
    
    return TextStyle(
        fontSize: SizeConfig.safeBlockHorizontal * 15,
        fontFamily: "Monoton",
        color: Colors.white,
      );
  }

  //Spin The Bottle Text
  static TextStyle spinTheBottleTextStyle({BuildContext context}) {

    SizeConfig().init(context);
    
    return TextStyle(
        fontSize: SizeConfig.safeBlockVertical * 6.66,
        fontFamily: "Tomorrow",
        fontWeight: FontWeight.bold,
        height: 1,
        letterSpacing: 8,
        color: Colors.white,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(5, 1),
            color: Color(0xFF00ffff).withOpacity(0.8),
            blurRadius: 2,
          ),
          Shadow(
            offset: Offset(-3, -1),
            color: Color(0xFFff00ff).withOpacity(0.8),
          ),
        ],
      );
    }
}
