import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:bottoms_up/services/size_config.dart';
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

    SizeConfig().init(context);
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.truthDareGradient, //background color
          ),
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 40,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: AppBase.tDlogoPadding(context),
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
                                  left: SizeConfig.blockSizeHorizontal * 2.56,
                                  top: SizeConfig.blockSizeVertical * 1.11,
                                  child: Container(
                                    child: Text(
                                      'TRUTH', //custom text style
                                      style: AppText.truthTextStyle(
                                        
                                        fontSize: SizeConfig.safeBlockHorizontal * 16.66,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: SizeConfig.blockSizeHorizontal * 20.40,
                                  left: SizeConfig.blockSizeHorizontal * 34.48,
                                  child: Text(
                                    'Or', //custom text style
                                    style: AppText.orTextStyle(
                                      
                                      fontSize: SizeConfig.safeBlockHorizontal * 7.69,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: SizeConfig.blockSizeHorizontal * 27.77,
                                  left: SizeConfig.blockSizeHorizontal * 36.63,
                                  child: Transform.rotate(
                                    angle: pi / 20,
                                    child: AppBase.truthDareHorns(), // horns vector //angled above DARE
                                  ),
                                ),
                                Positioned(
                                  top: SizeConfig.blockSizeHorizontal * 26.88,
                                  left: SizeConfig.blockSizeHorizontal * 38.75,
                                  child: Text(
                                    'Dare', //custom text style
                                    style: AppText.dareTextStyle(
                                    
                                      fontSize: SizeConfig.safeBlockHorizontal * 17.85,
                                      
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
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 26.66,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeHorizontal * 14.92
                    ),
                    child: BottomsUpButton(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      height: SizeConfig.blockSizeHorizontal * 20,
                      iconSize: SizeConfig.blockSizeHorizontal * 15.38,
                      shadowColor: AppColors.tDgradientRed,
                      iconColor: AppColors.truthDareButtonIcon,
                      function: () {
                        Navigator.pushNamed(context, '/truth_dare_mode'); //move to truth dare mode screen
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 33.33,
                child: Padding(
                  padding: AppBase.infoSettingsRow(
                      horizontalP: SizeConfig.blockSizeHorizontal * 10,
                      verticalP: SizeConfig.blockSizeHorizontal * 7.14
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => GameInfo(gameName: "Truth or Dare", gameDescription: AppText.truthDareDescription),
                            );
                        },
                        child: AppBase.standartInfoIcon(context),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {},
                          child: AppBase.standartSettingsIcon(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


