import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpinTheBottle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    print("width ${mediaQuery.size.width}");
    print("height ${mediaQuery.size.height}");

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.spinTheBottleGradient, //background color
          ),
          child: Column(
            children: [
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: mediaQuery.size.width,
                          height: mediaQuery.size.height / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "SPIN",
                                style: AppText.spinTheBottleTextStyle(mediaQuery: mediaQuery),
                              ),
                              Text(
                                "THE",
                                style: AppText.spinTheBottleTextStyle(mediaQuery: mediaQuery),
                              ),
                              Text(
                                "BOTTLE",
                                style: AppText.spinTheBottleTextStyle(mediaQuery: mediaQuery),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height / 2.5,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: mediaQuery.size.height  / 15, top: mediaQuery.size.height / 20.5),
                        child: BottomsUpButton(
                          width: mediaQuery.size.width / 5,
                          height: mediaQuery.size.width / 5,
                          iconSize: mediaQuery.size.width / 6.5,
                          shadowColor: Colors.black38,
                          iconColor: AppColors.sBgradientDarkRed,
                          function: () => Navigator.pushNamed(context, "/spin_the_bottle_players"),
                        ),
                      ),
                      Container(
                      child: 
                      Padding(
                        padding: EdgeInsets.only(top: mediaQuery.size.height / 45.5),
                        child: SvgPicture.asset(
                          "assets/images/SVG/bottle.svg",
                          semanticsLabel: "bottle",
                          height: mediaQuery.size.height / 6.8,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height / 5,
                child: Column(
                  children: [
                    Padding(
                      padding: AppBase.infoSettingsRow(
                          horizontalP: mediaQuery.size.width / 10,
                          verticalP: mediaQuery.size.height / 18.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => GameInfo(
                                    gameName: "Spin the Bottle",
                                    gameDescription: AppText.headsTailsDescription
                                    ),
                              );
                              print("Hello");
                            },
                            child: AppBase.standartInfoIcon(context),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                print("Hello");
                              },
                              child: AppBase.standartSettingsIcon(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}