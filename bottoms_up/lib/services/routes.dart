import 'package:bottoms_up/screens/games/headTails/head_tails_game.dart';
import 'package:bottoms_up/screens/games/kindsCup/kings_cup.dart';
import 'package:bottoms_up/screens/games/kindsCup/kings_cup_game.dart';
import 'package:bottoms_up/screens/games/spinBottle/spinBottle.dart';
import 'package:bottoms_up/screens/games/spinBottle/spinBottleGame.dart';
import 'package:bottoms_up/screens/games/spinBottle/spinBottlePlayers.dart';
import 'package:bottoms_up/screens/games/truthDare/truth_dare_cards.dart';
import 'package:bottoms_up/screens/games/truthDare/truth_dare_mode.dart';
import 'package:bottoms_up/screens/home.dart';
import 'package:bottoms_up/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  // ignore: missing_return
  static MaterialPageRoute materialPageRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (context) => Home());
      case '/truth_dare_mode':
        return MaterialPageRoute(builder: (context) => TruthDareMode());
      case '/truth_dare_cards':
        return MaterialPageRoute(builder: (context) => TruthDareCards());
      case '/setting_screen':
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case '/heads_tails_game':
        return MaterialPageRoute(builder: (context) => HeadsTailsGame());
      case '/kings_cup_menu':
        return MaterialPageRoute(builder: (context) => KingsCup());
      case '/kings_cup_game':
        return MaterialPageRoute(builder: (context) => KingsCupGame());
      case '/spin_the_bottle':
        return MaterialPageRoute(builder: (context) => SpinTheBottle());
      case '/spin_the_bottle_players':
        return MaterialPageRoute(builder: (context) => SpinBottlePlayers());
      case '/spin_the_bottle_game':
        return MaterialPageRoute(builder: (context) => SpinBottleGame());
    }
  }

  // ignore: missing_return
  static CupertinoPageRoute cupertinoPageRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return CupertinoPageRoute(builder: (context) => Home());
      case '/truth_dare_mode':
        return CupertinoPageRoute(builder: (context) => TruthDareMode());
      case '/truth_dare_cards':
        return CupertinoPageRoute(builder: (context) => TruthDareCards());
      case '/setting_screen':
        return CupertinoPageRoute(builder: (context) => SettingsScreen());
      case '/heads_tails_game':
        return CupertinoPageRoute(builder: (context) => HeadsTailsGame());
      case '/kings_cup_menu':
        return CupertinoPageRoute(builder: (context) => KingsCup());
      case '/kings_cup_game':
        return CupertinoPageRoute(builder: (context) => KingsCupGame());
      case '/spin_the_bottle':
        return CupertinoPageRoute(builder: (context) => SpinTheBottle());
      case '/spin_the_bottle_players':
        return CupertinoPageRoute(builder: (context) => SpinBottlePlayers());
      case '/spin_the_bottle_game':
        return CupertinoPageRoute(builder: (context) => SpinBottleGame());
    }
  }
}
