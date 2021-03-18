import 'package:bottoms_up/screens/home.dart';
import 'package:bottoms_up/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

abstract class AppBase {
  //SplashScreen
  static SplashScreen get splashScreen {
    return SplashScreen(
      imagePath: 'assets/images/beer.png',
      duration: 4000,
      home: Home(),
      backgroundColor: Color(0xFFfdc31c),
    );
  }

  //TruthDare Section
  static EdgeInsets tDlogoPadding(MediaQueryData mediaQuery) {
    return EdgeInsets.only(
      left: mediaQuery.size.width / 10,
      right: mediaQuery.size.width / 10,
      top: mediaQuery.size.height / 25,
    );
  }

  //Truth Dare game instructions
  static String get gameInfoText {
    return "The game is truth or dare, the rules are simple if you don't answer the truth or complete the dare you take a shot or do the forfeit indicated on the card. There is a couples mode in the settings if you are looking to spice things up with your partner. The game has two modes dirty and party, if you choose to play dirty prepare to have a crazy night whereas the party mode is for a more relaxed night.";
  }

  //padding for info and settings
  static EdgeInsets infoSettingsRow({double horizontalP, double verticalP}) {
    return EdgeInsets.symmetric(horizontal: horizontalP, vertical: verticalP);
  }

  //logos
  static Widget truthDareHalo([double width]) {
    return SvgPicture.asset(
      "assets/images/SVG/Halo.svg",
      semanticsLabel: "Halo",
      color: Colors.yellow,
      width: width,
    );
  }

  static Widget truthDareHorns([double width]) {
    return SvgPicture.asset(
      "assets/images/SVG/Horns.svg",
      semanticsLabel: "Horns",
      color: Colors.white,
      width: width,
    );
  }

  //Loading assets TruthDareCards screen
  static Widget get loadingLottie {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        child: Lottie.asset('assets/lottiefiles/beerLotie.json'),
      ),
    );
  }

  //HeadsTails Base
  static EdgeInsets hTlogoPadding(MediaQueryData mediaQuery) {
    return EdgeInsets.only(
        left: mediaQuery.size.width / 2.15, top: mediaQuery.size.height / 30.0);
  }

  static Widget flipCoinLogo({MediaQueryData mediaQuery}) {
    return SvgPicture.asset(
      "assets/images/SVG/coin.svg",
      semanticsLabel: "Coin",
      width: mediaQuery.size.width / 6.5,
      color: Color(0xffffde5a),
    );
  }

  static Widget get tossCoin {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Lottie.asset('assets/lottiefiles/flip_coin.json'),
      ),
    );
  }

  //AppBase standart
  static Icon standartSettingsIcon(MediaQueryData mediaQuery) {
    return Icon(Icons.settings,
        size: mediaQuery.size.width / 6.5, color: Colors.white);
  }

  static Icon standartInfoIcon(MediaQueryData mediaQuery) {
    return Icon(Icons.info,
        size: mediaQuery.size.width / 6.5, color: Colors.white);
  }

  //pop screen button
  static Padding appPopIcon(BuildContext context, VoidCallback onTap) =>
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.cancel_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            Visibility(
              visible: false,
              child: Icon(Icons.cancel_outlined, size: 30),
            ),
          ],
        ),
      );
}
