import 'dart:ui';

import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_game_card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/spin_bottle_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SpinBottleGame extends StatefulWidget {
  SpinBottleGame({Key key}) : super(key: key);

  @override
  _SpinBottleGameState createState() => _SpinBottleGameState();
}

class _SpinBottleGameState extends State<SpinBottleGame> with TickerProviderStateMixin {

  AnimationController _animationController;

  List<String> spinTheBottleQuestionsList = [];

  String challenger = "";
  String challengee = "";
  String challenge = ""; //comes from firestore

  void _loadQuestions() async{

    
    spinTheBottleQuestionsList = await DataRequest().getSpinTheBottleData();
    print(spinTheBottleQuestionsList.toString());

  }

  @override
  void initState() {

    _loadQuestions(); //load data

    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addStatusListener((AnimationStatus status) {

      if (status == AnimationStatus.completed) {
        setState(() {
          
          //get question
          spinTheBottleManager.getChallenge(spinTheBottleQuestionsList); //list should be loaded
          print(spinTheBottleQuestionsList);
          print(spinTheBottleManager.challenge);

          spinTheBottleQuestionsList.length == 0 ? _loadQuestions() : null;

          challengee = spinTheBottleManager.challengee.name;
          showDialog(
            barrierColor: Color(0x01000000),
            context: context,
            builder: (context) => GestureDetector(
              onTap: () {
                setState(() {
                  
                });
                _animationController.forward();
                Navigator.pop(context);
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                backgroundColor: AppColors.sBgradientDarkPurple,
                content: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          spinTheBottleManager?.challenge ?? "Try Again", 
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.repeat),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  spinTheBottleManager.getRandomPlayers();
                                  _animationController.reset();
                                  _animationController.forward();
                                  challengee = " ";
                                  Navigator.pop(context);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ).whenComplete(() => {
                setState(() {
                  spinTheBottleManager.getRandomPlayers();
                  _animationController.reset();
                  _animationController.forward();
                  challengee = " ";
                }),
              });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);
    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width


    if (spinTheBottleManager.showedInitialPopUp == false)
      Future.delayed(
        Duration.zero,
        () {

          spinTheBottleManager.getRandomPlayers();
          spinTheBottleManager.showedInitialPopUpF();

          showDialog(
            context: context,
            builder: (context) => GestureDetector(
              onTap: () {
                setState(() {
                  
                });
                _animationController.forward();
                Navigator.pop(context);
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                backgroundColor: AppColors.sBgradientDarkPurple,
                content: Container(
                  width: mediaQuery.size.width / 2,
                  height: mediaQuery.size.height / 4,
                  child: Center(
                    child: Text(
                      "${spinTheBottleManager?.challenger?.name} \n\n Click To Spin The Bottle",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ).whenComplete(() => {

            setState(() {


            }),
            _animationController.forward(),

          });
        },
      ); //spinTheBottleManager.getRandomPlayers()

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.spinTheBottleGradient, //background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppBase.appPopIcon(context, () {

                spinTheBottleManager.resetSpinBottleGame();
                _animationController.dispose();
                Navigator.pop(context);

              }, 15.0, 15.0, 0.0),
              SpinBottleGameCard(
                content: spinTheBottleManager?.challenger?.name ?? " ",
                borderColor: AppColors.sBblueChallengeColor,
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 3.5).animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOutBack)),
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      "assets/images/SVG/playing_bottle.svg",
                      semanticsLabel: "bottle",
                      color: Colors.white,
                      height: 300.0,
                    ),
                  ),
                ),
              ),
              SpinBottleGameCard(
                content: challengee ?? " ",
                borderColor: AppColors.sBredChallengeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
