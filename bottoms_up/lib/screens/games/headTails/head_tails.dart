import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/common_start_button.dart';
import 'package:bottoms_up/screens/game_info.dart';
import 'package:flutter/material.dart';

class HeadsTails extends StatelessWidget {
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
            gradient: AppColors.headsTailsGradient,
          ),
          child: Column(
            children: [
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height / 2.5,
                child: Column(
                  children: [
                    Padding(
                      padding: AppBase.hTlogoPadding(mediaQuery),
                      child: AppBase.flipCoinLogo(mediaQuery: mediaQuery),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            // left: 120.5,
                            top: 0.0,
                            child: AppText.headsTailsTitleText(
                                text: "HEADS", size: mediaQuery.size.width / 7.22),
                          ),
                          Positioned(
                            top: -mediaQuery.size.height / 139.0,
                            left: mediaQuery.size.width / 4.1,
                            child: AppText.headsTailsTitleText(
                                text: "HEADS", size: mediaQuery.size.width / 7.22),
                          ),
                          Positioned(
                            top: mediaQuery.size.height / 11.5,
                            child: AppText.headsTailsTitleText(
                                text: "OR", size: mediaQuery.size.width / 9.28),
                          ),
                          Positioned(
                            top: mediaQuery.size.height / 6.5,
                            child: AppText.headsTailsTitleText(
                                text: "TAILS", size: mediaQuery.size.width / 7.22),
                          )
                        ],
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
                      shadowColor: AppColors.hTButtonShadow,
                      iconColor: AppColors.hTButtonIcon,
                      function: () {
                        Navigator.pushNamed(context, "/heads_tails_game");
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
                              builder: (context) => GameInfo(gameName: "Heads Or Tails", gameDescription: AppText.headsTailsDescription),
                            );
                        },
                        child: AppBase.standartInfoIcon(context),
                      ),
                      GestureDetector(
                        onTap: () {
                         
                        },
                        child: AppBase.standartSettingsIcon(context),
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
