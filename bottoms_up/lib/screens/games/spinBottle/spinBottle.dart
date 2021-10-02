import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpinTheBottle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);

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
                width: SizeConfig.blockSizeHorizontal * 50,
                height: SizeConfig.blockSizeVertical * 40,
                child: SvgPicture.asset(
                  "assets/images/SVG/spinTheBottle.svg",
                  semanticsLabel: "spinTheBottle",
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 26.66,
                child: Center(
                  child: BottomsUpButton(
                    width: SizeConfig.blockSizeHorizontal * 18,
                    height: SizeConfig.blockSizeHorizontal * 18,
                    iconSize: SizeConfig.blockSizeHorizontal * 13.38,
                    corner: SizeConfig.safeBlockHorizontal * 18,
                    shadowColor: Colors.black38,
                    iconColor: AppColors.sBgradientDarkRed,
                    function: () => Navigator.pushNamed(
                        context, "/spin_the_bottle_players"),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 15,
                child: SvgPicture.asset(
                  "assets/images/SVG/bottle.svg",
                  semanticsLabel: "bottle",
                ),
              ),
              Expanded(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 13.33,
                  child: Padding(
                    padding: AppBase.infoSettingsRow(
                      horizontalP: SizeConfig.blockSizeHorizontal * 10,
                      verticalP: SizeConfig.blockSizeVertical * 5.14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => GameInfo(
                                  gameName: "Spin the Bottle",
                                  gameDescription:
                                      AppText.headsTailsDescription),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
