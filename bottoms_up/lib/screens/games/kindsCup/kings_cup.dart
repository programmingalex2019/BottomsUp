import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KingsCup extends StatelessWidget {
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
            gradient: AppColors.kingsCupGradient, //background color
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
                      child: Container(
                        width: mediaQuery.size.width,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: mediaQuery.size.height / 13.0,
                              right: mediaQuery.size.width / 1.54,
                              child: SvgPicture.asset(
                                "assets/images/SVG/crown.svg",
                                semanticsLabel: "Crown",
                                color: Colors.white,
                                width: mediaQuery.size.height / 20.0,
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.size.height / 6.8,
                              left: (mediaQuery.size.width / 4.0),
                              child: Text(
                                "KINGS",
                                style: AppText.kingsCupTextStyle(mediaQuery: mediaQuery),
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.size.height / 4.5,
                              left: (mediaQuery.size.width / 3.2),
                              child: Text(
                                "CUP",
                                style: AppText.kingsCupTextStyle(mediaQuery: mediaQuery),
                              ),
                            )
                          ],
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
                          iconColor: AppColors.kCgradientDarkGreen,
                          function: () => Navigator.pushNamed(context, "/kings_cup_game"),
                        ),
                      ),
                      Container(
                      child: SvgPicture.asset(
                        "assets/images/SVG/twoCards.svg",
                        semanticsLabel: "twoCards",
                        width: mediaQuery.size.height / 5,
                        height: mediaQuery.size.height / 5.5,
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
                                    gameName: "Kings Cup",
                                    gameDescription: AppText.headsTailsDescription),
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
