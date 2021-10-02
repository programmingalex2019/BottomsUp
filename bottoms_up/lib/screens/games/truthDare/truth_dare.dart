import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TruthDare extends StatefulWidget {
  @override
  _TruthDareState createState() => _TruthDareState();
}

class _TruthDareState extends State<TruthDare> {
  @override
  Widget build(BuildContext context) {

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
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.blockSizeVertical * 40,
                child: SvgPicture.asset(
                  "assets/images/SVG/truthDareLogo.svg",
                  semanticsLabel: "truthDareLogo",
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
                    shadowColor: AppColors.tDgradientRed,
                    iconColor: AppColors.truthDareButtonIcon,
                    function: () {
                      Navigator.pushNamed(context,
                          '/truth_dare_mode'); //move to truth dare mode screen
                    },
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 15,
              ),
              Expanded(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 13.33,
                  child: Padding(
                    padding: AppBase.infoSettingsRow(
                        horizontalP: SizeConfig.blockSizeHorizontal * 10,
                        verticalP: SizeConfig.blockSizeVertical * 5.14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => GameInfo(
                                  gameName: "Truth or Dare",
                                  gameDescription: AppText.truthDareDescription),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}




