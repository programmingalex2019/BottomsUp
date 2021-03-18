import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/truth_dare/truth_dare_mode_button.dart';
import 'package:bottoms_up/design/buttons/truth_dare/truth_dare_start_cards_button.dart';
import 'package:bottoms_up/services/truth_dare_manager.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class TruthDareMode extends StatefulWidget {
  @override
  _TruthDareModeState createState() => _TruthDareModeState();
}

class _TruthDareModeState extends State<TruthDareMode>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var truthDareManager =
        Provider.of<TruthDareManager>(context, listen: false);

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
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
              }),
              Container(
                width: (mediaQuery.size.width) / 1.5,
                height: (mediaQuery.size.height / 6) / 0.8,
                child: Transform.rotate(
                  angle: -pi / 18,
                  child: Stack(
                    children: [
                      Positioned(
                        left: (mediaQuery.size.width / 15) / 1.5,
                        child: Transform.rotate(
                            angle: pi / 13,
                            child: AppBase.truthDareHalo(
                              mediaQuery.size.width / 11.0,
                            ) //optional width

                            ),
                      ),
                      Positioned(
                        left: (mediaQuery.size.width / 10) / 1.5,
                        top: (mediaQuery.size.height / 90) / 1.5,
                        child: Container(
                          child: Text(
                            'TRUTH',
                            style: AppText.truthTextStyle(
                              mediaQuery: mediaQuery,
                              fontSize: (mediaQuery.size.width / 6.0) / 1.5,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: (mediaQuery.size.width / 4.9) / 1.5,
                        left: (mediaQuery.size.width / 2.6) / 1.5,
                        child: Text(
                          'Or',
                          style: AppText.orTextStyle(
                            mediaQuery: mediaQuery,
                            fontSize: 32,
                          ), //TODO: change this
                        ),
                      ),
                      Positioned(
                        top: (mediaQuery.size.width / 3.10) / 1.5,
                        left: (mediaQuery.size.width / 2.23) / 1.5,
                        child: Transform.rotate(
                            angle: pi / 20,
                            child: AppBase.truthDareHorns(
                              mediaQuery.size.width / 12,
                            ) //optional width
                            ),
                      ),
                      Positioned(
                        top: (mediaQuery.size.width / 3.15) / 1.5,
                        left: (mediaQuery.size.width / 2.1) / 1.5,
                        child: Text(
                          'DARE',
                          style: AppText.dareTextStyle(
                            mediaQuery: mediaQuery,
                            fontSize: (mediaQuery.size.width / 5.6) / 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TruthDareStartCardsButton(
                width: mediaQuery.size.width / 6,
                height: mediaQuery.size.width / 6,
                iconSize: mediaQuery.size.width / 10,
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
