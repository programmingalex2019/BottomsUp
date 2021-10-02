import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/truth_dare/card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/exceptions.dart';
import 'package:bottoms_up/services/heads_tails_manager.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class HeadsTailsGame extends StatefulWidget {
  @override
  _HeadsTailsGameState createState() => _HeadsTailsGameState();
}

class _HeadsTailsGameState extends State<HeadsTailsGame> with TickerProviderStateMixin {
  
  AnimationController _controller;
  Future<List<String>> _questions;

  Future<List<String>> _getQuestions() async {

    return CustomException.tryFunction(() => DataRequest().getHeadsTailsData());

  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
      lowerBound: 0,
      upperBound: 1.0,
    );

    _questions = _getQuestions();

  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    
    final HeadsTailsManager hTmanager = Provider.of<HeadsTailsManager>(context, listen: false);

    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          decoration: BoxDecoration(
            gradient: AppColors.headsTailsGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [

                AppBase.appPopIcon(context, () {

                  hTmanager.setDefault();
                  hTmanager.reasignText(); // change coin text to toss me
                  Navigator.pop(context);

                }, SizeConfig.safeBlockHorizontal * 3.66, SizeConfig.safeBlockHorizontal * 6.66, SizeConfig.safeBlockVertical * 2),

                Container(
                  width: SizeConfig.blockSizeHorizontal * 95,
                  height: SizeConfig.blockSizeVertical * 50,
                  child: FutureBuilder<List<String>>(
                    future: _questions,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:

                          return AppBase.loadingLottie;
                          break;

                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');

                          else if (snapshot.data == null) {
                            return Text('Error: ${snapshot.error}');
                            
                          }else
                            return SwipeStack(
                              children: snapshot.data.map(
                                (String question) {
                                  return SwiperItem(
                                    builder: (SwiperPosition position, double progress) {
                                      return SwipeAppCard(
                                        borderColor: Colors.black87,
                                        currentCardType: hTmanager.currentGameType, //so it appears at the top
                                        currentQuestion: hTmanager.currentQuestion,
                                        currentCardTypeTextStyle:                                 
                                            AppText.headsTailsCardTextStyle(
                                              fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                              color: AppColors.hTgradientPurple,
                                            ),
                                        currentQuestionTextStyle:
                                            AppText.headsTailsCardTextStyleContent(
                                              fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                              color: Colors.black,
                                            ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                              visibleCount: 3,
                              stackFrom: StackFrom.Bottom,
                              translationInterval: (SizeConfig.blockSizeVertical * 2.5).round(),
                              scaleInterval: 0.03,
                              onEnd: () async {

                                _questions = _getQuestions();
                                setState(() {});

                              },
                              onSwipe: (int index, SwiperPosition position) {
                                
                                hTmanager.shuffleAndReturn(snapshot.data); // take from firestore -> shuffle -> and assign current question
                                setState(
                                  () {
                                    hTmanager.reasignText(); // change coin text to toss me
                                  },
                                );
                              },
                              onRewind: (int index, SwiperPosition position) => debugPrint("onRewind $index $position"),
                            );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {

                      setState(() {
                        hTmanager.duringTossText(); // makes it to ' '
                      });

                      Future.delayed(Duration(milliseconds: 1000)).then((value) {
                        //show the text earlier than the finish of coin toss
                        setState(() {
                          hTmanager.assignText(); // either heads or tails
                        });
                      });

                      _controller.forward().then((value) {
                        _controller.value = 0.0;
                      });
                    },
                    child: AppBase.tossCoin(context: context, controller: _controller, headsTailsManager: hTmanager),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
