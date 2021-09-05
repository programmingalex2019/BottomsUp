import 'package:bottoms_up/screens/games/headTails/head_tails.dart';
import 'package:bottoms_up/screens/games/kindsCup/kings_cup.dart';
import 'package:bottoms_up/screens/games/spinBottle/spinBottle.dart';
import 'package:bottoms_up/screens/games/truthDare/truth_dare.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentPage = 0;

  LiquidController liquidController;

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            LiquidSwipe(
              pages: liquidPages,
              liquidController: liquidController,
              fullTransitionValue: 1000, //how long transition
              enableLoop: true, //start from beginning when ended
              enableSideReveal: false,
              slideIconWidget: Icon(Icons.arrow_left),
              positionSlideIcon: 0.7,
              waveType: WaveType.liquidReveal,
              onPageChangeCallback: (page) => pageChangeCallback(page),
              currentUpdateTypeCallback: (updateType) => updateTypeCallback(updateType),
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
  SpinTheBottle(),
];
