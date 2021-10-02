import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/buttons/truth_dare/truth_dare_mode_button.dart';
import 'package:bottoms_up/design/buttons/truth_dare/truth_dare_start_cards_button.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:bottoms_up/services/truth_dare_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TruthDareMode extends StatefulWidget {
  @override
  _TruthDareModeState createState() => _TruthDareModeState();
}

class _TruthDareModeState extends State<TruthDareMode> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    TruthDareManager truthDareManager = Provider.of<TruthDareManager>(context, listen: false);

    SizeConfig().init(context);

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          decoration: BoxDecoration(
            gradient: AppColors.truthDareGradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppBase.appPopIcon(context, () {
                  truthDareManager.resetAllType(); //makes all modes disabled so the animations of buttion works properly
                  truthDareManager.updateQuestions();
                  Navigator.pop(context);
                }, SizeConfig.safeBlockHorizontal * 6.66, SizeConfig.safeBlockHorizontal * 6.66, SizeConfig.safeBlockVertical * 2),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.safeBlockVertical * 18,
                  child: SvgPicture.asset(
                    "assets/images/SVG/truthDareLogo.svg",
                    semanticsLabel: "truthDareLogo",
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                TruthDareStartCardsButton(
                    width: SizeConfig.blockSizeHorizontal * 19,
                    height: SizeConfig.blockSizeHorizontal * 19,
                    iconSize: SizeConfig.blockSizeHorizontal * 9,
                    corner: SizeConfig.blockSizeHorizontal * 38,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                TruthModeButton(
                  mediaQuery: mediaQuery,
                  text: 'Party',
                  updateState: () {
                    setState(() {});
                  },
                ),
                TruthModeButton(
                  mediaQuery: mediaQuery,
                  text: 'Dirty',
                  updateState: () {
                    setState(() {});
                  },
                ),
                TruthModeButton(
                  mediaQuery: mediaQuery,
                  text: 'Couples',
                  updateState: () {
                    setState(() {});
                  },
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

