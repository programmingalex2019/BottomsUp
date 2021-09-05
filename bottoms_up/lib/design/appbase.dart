import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/screens/home.dart';
import 'package:bottoms_up/screens/splash.dart';
import 'package:bottoms_up/services/heads_tails_manager.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:playing_cards/playing_cards.dart';

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

  //AppBase standart
  static Icon standartSettingsIcon(BuildContext context) {

    SizeConfig().init(context);

    return Icon(Icons.settings,
        size: SizeConfig.blockSizeHorizontal * 15.38, color: Colors.white);
  }

  static Icon standartInfoIcon(BuildContext context) {

    SizeConfig().init(context);

    return Icon(Icons.info,
        size: SizeConfig.blockSizeHorizontal * 15.38, color: Colors.white);
  }

  //pop screen button
  static Padding appPopIcon(BuildContext context, VoidCallback onTap, double left, right, top) =>
      Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top),
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

  //TruthDare Section
  static EdgeInsets tDlogoPadding(BuildContext context) {

    SizeConfig().init(context);

    return EdgeInsets.only(
      left: SizeConfig.blockSizeHorizontal * 10,
      right: SizeConfig.blockSizeHorizontal * 10,
      top: SizeConfig.blockSizeHorizontal * 4,
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

  static Widget tossCoin(
      {MediaQueryData mediaQuery,
      Animation<double> controller,
      HeadsTailsManager headsTailsManager}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          'assets/lottiefiles/flip_coin.json',
          width: mediaQuery.size.height / 2.7,
          controller: controller,
        ),
        Material(
          child: Text(
            headsTailsManager.defaultCointText,
            style: AppText.headTailsCoinTextStyle(
              fontSize: mediaQuery.size.height / 28,
            ),
          ),
          color: Colors.black.withOpacity(0),
        ),
      ],
    );
  }

//KingsCup Base

  static List<PlayingCardView> fourKings() => [
        PlayingCardView(
          card: PlayingCard(Suit.hearts, CardValue.king),
          showBack: true,
          elevation: 3.0,
        ),
        PlayingCardView(
            card: PlayingCard(Suit.hearts, CardValue.king),
            showBack: true,
            elevation: 3.0),
        PlayingCardView(
            card: PlayingCard(Suit.hearts, CardValue.king),
            showBack: true,
            elevation: 3.0),
        PlayingCardView(
            card: PlayingCard(Suit.hearts, CardValue.king),
            elevation: 3.0,
            showBack: true)
      ];

  static PlayingCardViewStyle introCardStyle() =>
      PlayingCardViewStyle(suitStyles: {
        Suit.spades: SuitStyle(
            builder: (context) => FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "",
                  ),
                ),
            style: TextStyle(color: AppColors.kCgradientLightGreen),
            cardContentBuilders: {
              CardValue.king: (context) => SvgPicture.asset(
                    "assets/images/SVG/crown.svg",
                    semanticsLabel: "Crown",
                    color: AppColors.kCgradientLightGreen,
                  ),
            })
      });

  //SpinBottlePlayes
  static InputDecoration addPlayerTextFieldDecoration() => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        errorStyle: TextStyle(
          color: Colors.yellow,
          fontSize: 15.0,
        ),
        errorMaxLines: 2,
      );

  static TextStyle sBconstraintsTextStyle(Color color) => TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 14.0,
      color: color);
}
