import 'dart:ui';

import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_game_card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/exceptions.dart';
import 'package:bottoms_up/services/size_config.dart';
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

  Future<Map<String, Set<List<String>>>> _spinTheBottleCombinations;

  String challenger = "";
  String challengee = "";
  String challenge = ""; //comes from firestore

  Future<Map<String, Set<List<String>>>> _loadQuestions() async { 
    
    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);
    return CustomException.tryFunction(() => DataRequest().getSpinTheBottleData(spinTheBottleManager.players));

  }

  @override
  void initState() {

    _spinTheBottleCombinations = _loadQuestions(); //load data

    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));

    _animationController.addStatusListener((AnimationStatus status) {
      
      if (status == AnimationStatus.completed) {

        SizeConfig().init(context);

        setState(() {

          //assign manager data to state data
          challenger = spinTheBottleManager.challenger;
          challengee = spinTheBottleManager.challengee;

          showDialog(

            barrierDismissible: false,
            barrierColor: Color(0x01000000),
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 6.66)),
              backgroundColor: AppColors.sBgradientDarkPurple,
              content: Container(
                width: SizeConfig.blockSizeHorizontal * 45,
                height: SizeConfig.blockSizeVertical * 25,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        spinTheBottleManager?.challenge ?? "Try Again",
                        style: TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 6),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: IconButton(
                              iconSize: SizeConfig.safeBlockHorizontal * 8,
                              icon: Icon(Icons.repeat),
                              color: Colors.white,
                              onPressed: () {
                                //if no more combinations 
                                if (spinTheBottleManager.tupples.isEmpty) {

                                  setState(() {

                                    _animationController.reset();
                                    spinTheBottleManager.resetShowedInitialPopUp(); //so that first pop shows up

                                    //reset while animating
                                    challengee = " ";
                                    challenger = " ";

                                    _spinTheBottleCombinations = _loadQuestions(); //triggers future builder 
                                    
                                    Navigator.pop(context);

                                  });

                                } else {

                                  //if combinations exist 
                                  setState(
                                    () {

                                      spinTheBottleManager.getChallenge(spinTheBottleManager.tupples); //list should be loaded //random players already selected
                                      _animationController.reset();
                                      _animationController.forward();

                                      //reset while animating
                                      challengee = " ";
                                      challenger = " ";

                                      Navigator.pop(context);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              iconSize: SizeConfig.safeBlockHorizontal * 8,
                              color: Colors.white,
                              onPressed: () {
                                //pop up exit to players screen 
                                spinTheBottleManager.resetSpinBottleGame();
                                _animationController.dispose();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);

    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.spinTheBottleGradient, //background color
          ),
          child: FutureBuilder<Map<String, Set<List<String>>>>(
              future: _spinTheBottleCombinations,
              builder: (context, snapshot) {

                switch (snapshot.connectionState) {
                  
                  case ConnectionState.waiting:

                    return AppBase.loadingLottie;
                    break;

                  default:

                    if (snapshot.hasError) //comes from custom throw exception
                      return Center(child: Text('${snapshot.error}'));

                    else if (snapshot.data == null) {

                      return Center(child: Text('${snapshot.error}'));

                    } else {

                      //first time entering game 
                      if (spinTheBottleManager.showedInitialPopUp == false)

                        Future.delayed(
                          Duration.zero,
                          () {
                            
                            spinTheBottleManager.showedInitialPopUpF(); //after rebuild this wont be called
                            spinTheBottleManager.tupples = snapshot.data; //copy server to manager first time

                            showGeneralDialog(
                              context: context,
                              pageBuilder: (context, anim1, anim2) {},
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionDuration: Duration(milliseconds: 250),
                              transitionBuilder: (context, anim1, anim2, child) {

                                return Transform.scale(
                                  scale: anim1.value,
                                  child: GestureDetector(
                                  onTap: () {

                                    spinTheBottleManager.getChallenge(snapshot.data); //list should be loaded //random players already selected
                                    _animationController.forward();
                                    Navigator.pop(context);

                                  },
                                  child: 
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 6.66)),
                                      backgroundColor: AppColors.sBgradientDarkPurple,
                                      content: Container(
                                        width: SizeConfig.blockSizeHorizontal * 45,
                                        height: SizeConfig.blockSizeVertical * 25,
                                        child: Center(
                                          child: Text(
                                            "Click To Spin The Bottle",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: SizeConfig.safeBlockHorizontal * 6,
                                              ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } 
                            );
                          },
                        );

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          AppBase.appPopIcon(context, () {

                            spinTheBottleManager.resetSpinBottleGame();
                            _animationController.dispose();
                            Navigator.pop(context);

                          }, SizeConfig.safeBlockHorizontal * 3.66, SizeConfig.safeBlockHorizontal * 6.66, SizeConfig.safeBlockVertical * 2),

                          SpinBottleGameCard(
                            content: challenger ?? " ",
                            borderColor: AppColors.sBblueChallengeColor,
                          ),

                          RotationTransition(
                            turns: Tween(begin: 0.0, end: 3.5).animate(
                                CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.easeInOutBack),
                                  ),

                            child: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 6),
                                child: SvgPicture.asset(
                                  "assets/images/SVG/playing_bottle.svg",
                                  semanticsLabel: "bottle",
                                  color: Colors.white,
                                  height: SizeConfig.safeBlockVertical * 35,
                                ),
                              ),
                            ),
                          ),

                          SpinBottleGameCard(
                            content: challengee ?? " ",
                            borderColor: AppColors.sBredChallengeColor,
                          ),
                        ],
                      ); //spinTheBottleManager.getRandomPlayers()
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
