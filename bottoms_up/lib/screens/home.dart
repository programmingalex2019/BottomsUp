import 'package:bottoms_up/screens/games/headTails/head_tails.dart';
import 'package:bottoms_up/screens/games/kindsCup/kings_cup.dart';
import 'package:bottoms_up/screens/games/truthDare/truth_dare.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: [
            LiquidSwipe(
              pages: liquidPages,
              fullTransitionValue: 1000, //how long transition
              enableLoop: true, //start from beginning when ended
              enableSlideIcon:
                  true, //arrow //can be edited // positionSlideIcon y axis
              positionSlideIcon: 0.8,
              waveType: WaveType.liquidReveal,
              onPageChangeCallback: (page) => pageChangeCallback(page),
              currentUpdateTypeCallback: (updateType) =>
                  updateTypeCallback(updateType),
            ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int page) {
    setState(() {
      currentPage = page;
    });
  }

  updateTypeCallback(UpdateType updateType) {
    
  }
}

final textStyle = TextStyle(fontSize: 20.0, color: Colors.white);

final liquidPages = [
  TruthDare(), //TruthDare
  HeadsTails(),
  KingsCup(),
];
