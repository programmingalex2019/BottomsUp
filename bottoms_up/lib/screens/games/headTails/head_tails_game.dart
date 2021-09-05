import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/truth_dare/card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/heads_tails_manager.dart';
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
    return await DataRequest().getHeadsTailsData();
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
    
    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    final HeadsTailsManager hTmanager = Provider.of<HeadsTailsManager>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          decoration: BoxDecoration(
            gradient: AppColors.headsTailsGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                AppBase.appPopIcon(context, () {
                  hTmanager.setDefault();
                  Navigator.pop(context);
                  hTmanager.reasignText(); // change coin text to toss me
                },15.0, 15.0, 15.0),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height / 2,
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
                            print(snapshot.data.toString());
                            return SwipeStack(
                              children: snapshot.data.map(
                                (String question) {
                                  return SwiperItem(
                                    builder:
                                        (SwiperPosition position, double progress) {
                                      return SwipeAppCard(
                                        borderColor: AppColors.hTyellowColor,
                                        currentCardType: hTmanager
                                            .currentGameType, //so it appears at the top
                                        currentQuestion: hTmanager.currentQuestion,
                                        currentCardTypeTextStyle:
                                            AppText.headsTailsCardTextStyle(
                                                fontSize: mediaQuery.size.height / 29,
                                                color: AppColors.hTgradientPurple),
                                        currentQuestionTextStyle:
                                            AppText.headsTailsCardTextStyle(
                                                fontSize: mediaQuery.size.height / 30,
                                                color: AppColors.hTyellowColor),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                              visibleCount: 3,
                              stackFrom: StackFrom.Bottom,
                              translationInterval: 20,
                              scaleInterval: 0.03,
                              onEnd: () async {
                                _questions = _getQuestions();
                                setState(
                                  () {},
                                );
                              },
                              onSwipe: (int index, SwiperPosition position) {hTmanager.shuffleAndReturn(snapshot.data); // take from firestore -> shuffle -> and assign current question
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
                    child: AppBase.tossCoin(mediaQuery: mediaQuery, controller: _controller, headsTailsManager: hTmanager),
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
