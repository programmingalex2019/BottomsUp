import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TruthDare extends StatefulWidget {
  @override
  _TruthDareState createState() => _TruthDareState();
}

class _TruthDareState extends State<TruthDare> {
@override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.truthDareGradient, //background color
      ),
      child: Column(
        children: [
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height / 2.5,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: AppBase.tDlogoPadding(mediaQuery),
                    child: Container(
                      width: mediaQuery.size.width, //no height since expanded
                      child: Transform.rotate(
                        angle: -pi / 18, //angle the TRUTH text
                        child: Stack(
                          children: [
                            Positioned(
                              child: Transform.rotate(
                                angle: pi / 13,
                                child: AppBase
                                    .truthDareHalo(), // halo vector angled
                              ),
                            ),
                            Positioned(
                              left: mediaQuery.size.width / 39,
                              top: mediaQuery.size.height / 90,
                              child: Container(
                                child: Text(
                                  'TRUTH', //custom text style
                                  style: AppText.truthTextStyle(
                                    mediaQuery: mediaQuery,
                                    fontSize: mediaQuery.size.width / 6.0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.size.width / 4.9,
                              left: mediaQuery.size.width / 2.9,
                              child: Text(
                                'Or', //custom text style
                                style: AppText.orTextStyle(
                                  mediaQuery: mediaQuery,
                                  fontSize: mediaQuery.size.width / 13,
                                ),
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.size.width / 3.6,
                              left: mediaQuery.size.width / 2.73,
                              child: Transform.rotate(
                                angle: pi / 20,
                                child: AppBase
                                    .truthDareHorns(), // horns vector //angled above DARE
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.size.width / 3.72,
                              left: mediaQuery.size.width / 2.58,
                              child: Text(
                                'Dare', //custom text style
                                style: AppText.dareTextStyle(
                                  mediaQuery: mediaQuery,
                                  fontSize: mediaQuery.size.width / 5.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height / 3.75,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: mediaQuery.size.width / 6.7),
                child: BottomsUpButton(
                  width: mediaQuery.size.width / 5,
                  height: mediaQuery.size.width / 5,
                  iconSize: mediaQuery.size.width / 6.5,
                  shadowColor: AppColors.tDgradientRed,
                  iconColor: AppColors.truthDareButtonIcon,
                  function: () {
                    Navigator.pushNamed(context,
                        '/truth_dare_mode'); //move to truth dare mode screen
                  },
                ),
              ),
            ),
          ),
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height / 3,
            child: Padding(
              padding: AppBase.infoSettingsRow(
                  horizontalP: mediaQuery.size.width / 10,
                  verticalP: mediaQuery.size.height / 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => GameInfo(gameName: "Truth or Dare", gameDescription: "Game Description"),
                        );
                        print("Hello");
                    },
                    child: AppBase.standartInfoIcon(mediaQuery),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        print("Hello");
                      },
                      child: AppBase.standartSettingsIcon(mediaQuery),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


