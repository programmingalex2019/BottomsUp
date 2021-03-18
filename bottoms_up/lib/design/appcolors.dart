import 'package:flutter/material.dart';

abstract class AppColors {
  //TruthDare section
  static Color get tDgradientYellow => Color(0xFFf9ca52);

  static Color get tDgradientRed => Color(0xFFd33523);

  static Color get truthDareButtonIcon => Color(0xFFff5756);

  static Color get truthDareCardBorderColor => Color(0xFFff5756);

  static LinearGradient get truthDareGradient => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        colors: [
          tDgradientYellow,
          tDgradientRed,
        ],
        stops: [0.1, 0.7],
      );

  //heads tails section
  static Color get hTgradientPurple => Colors.deepPurple[800];
  static Color get hTgradientPink => Colors.purple;
  static Color get hTButtonIcon => Colors.deepPurple[400];
  static Color get hTButtonShadow => Colors.purple[900];
  static Color get wRcardBorderColor => Color(0xFFffbd59);

  static LinearGradient get headsTailsGradient => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: [
          hTgradientPurple,
          hTgradientPink,
        ],
        stops: [0.1, 0.77],
      );

  //KingsCup section

  static Color get kCgradientDarkGreen => Color(0xFF02AAB0);
  static Color get kCgradientLightGreen => Color(0xFF00CDAC);
  static LinearGradient get kingsCupGradient => LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [kCgradientDarkGreen, kCgradientLightGreen],
        stops: [
          0.6,
          0.75,
        ],
      );
}
