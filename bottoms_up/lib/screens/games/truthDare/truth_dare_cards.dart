import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/truth_dare/truth_dare_direction.dart';
import 'package:bottoms_up/design/truth_dare/card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/truth_dare_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class TruthDareCards extends StatefulWidget {
  @override
  _TruthDareCardsState createState() => _TruthDareCardsState();
}

class _TruthDareCardsState extends State<TruthDareCards> {
  final GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();
  Future<List<List<String>>> _dbQuestions;

  Future<List<List<String>>> _getQuestions() async {
    var truthDareManager =
        Provider.of<TruthDareManager>(context, listen: false);
    _dbQuestions = DataRequest().getTruthDareData(truthDareManager.questions);
    return await DataRequest().getTruthDareData(truthDareManager.questions);
  }

  void _cardContentManagement({int truthOrDare,TruthDareManager manager, AsyncSnapshot<List<List<String>>> snapshot, String currentCardType}) {
    
    manager.shuffleAndReturn(snapshot.data[truthOrDare]); //get questions from dare/truth stack
    manager.setCurrentCardType(currentCardType); //set current card type
    manager.setCurrentGameType(manager.questions[0]); //set current game mode

    //0 is  truth //1 is dare
    if (snapshot.data[truthOrDare].length < 1) {
      manager.drinkResponsibly();
      _dbQuestions = _getQuestions();
      setState(
        () {},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _dbQuestions = _getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    var truthDareManager = Provider.of<TruthDareManager>(context, listen: false); //change notifier class

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: AppColors.truthDareGradient,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppBase.appPopIcon(context, () {
                  truthDareManager
                      .updateCurrentQuestionAndCardType(); //default initial question and card type
                  Navigator.pop(context);
                }),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height / 1.7,
                  child: FutureBuilder<List<List<String>>>(
                    future: _dbQuestions, //firebase data
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text("Please check your Internet Connection");
                          break;
                        case ConnectionState.active:
                          return AppBase.loadingLottie;
                          break;
                        case ConnectionState.waiting:
                          return AppBase.loadingLottie;
                          break;
                        case ConnectionState.done:
                          return SwipeStack(
                            key: _swipeKey,
                            children: (snapshot.data[0] + snapshot.data[1]).map(
                              (String question) {
                                return SwiperItem(
                                  builder: (SwiperPosition position,
                                      double progress) {
                                    return SwipeAppCard(
                                      borderColor: Colors.black87,
                                      currentGameType:
                                          truthDareManager.currentGameType,
                                      currentQuestion:
                                          truthDareManager.currentQuestion,
                                      currentCardType:
                                          truthDareManager.currentCardType,
                                      currentCardTypeTextStyle:
                                          AppText.tDcurrentCardTypeTextStyle(),
                                      currentQuestionTextStyle:
                                          AppText.tDcurrentQuestionTextStyle(),
                                      currentGameTypeTextStyle:
                                          AppText.tDcurrentGameTypeTextStyle(),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                            visibleCount: 3,
                            stackFrom: StackFrom.Bottom,
                            translationInterval: 15,
                            scaleInterval: 0.05,
                            animationDuration: Duration(milliseconds: 300),
                            onEnd:
                                () {}, //since lis splited into truth dare - this will happen -
                            onSwipe: (int index, SwiperPosition position) {
                              if (position == SwiperPosition.Left) {
                                _cardContentManagement(
                                  truthOrDare: 0,
                                  currentCardType: "Dare",
                                  snapshot: snapshot,
                                  manager: truthDareManager,
                                );
                              }
                              if (position == SwiperPosition.Right) {
                                _cardContentManagement(
                                  truthOrDare: 1,
                                  currentCardType: "Truth",
                                  snapshot: snapshot,
                                  manager: truthDareManager,
                                );
                              }
                            },
                            onRewind: (int index, SwiperPosition position) {},
                          ); // snapshot.data
                          break;
                        default:
                          return AppBase.loadingLottie;
                          break;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TruthDareDirection(
                      icon: Icons.chevron_left,
                      function: () {
                        _swipeKey.currentState.swipeLeft();
                      },
                    ),
                    TruthDareDirection(
                      icon: Icons.chevron_right,
                      function: () {
                        _swipeKey.currentState.swipeRight();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      ),
     )
    );
  }
}
//  ["What's your partner's worst quality?", "What's the smallest thing you fought over?", "What's your partner's best quality?", "What's something about the other person you would change?", "What's your favourite thing to do together?", "What's your biggest insecurity about the relationship?", "Rank all your relationships, this one included.", "Did you ever go through your partner's phone without them knowing?", "Tell the other person something you've always been scared to tell them.", "Who's the more attractive person in the relationship?", "What do the other person's parents really think about the respective person?", "What do you each think about the other person's parents?", "Have you ever had the opportunity to cheat?", "What's something you couldn't give up even for your partner?", "What's the biggest lie you told your partner?", "If you had to change something on your partner's body what would it be?", "What's something you do on dates that you'd like to change?", "What was the worst thing your partner gifted you?", "What was the best thing your partner gifted you?", "How much money would you be willing to end the relationship for?", "Dogs or cats or kids?", "Which of the other person's friends do you like talking to and which do you not like talking to?", "Has either of you ever been to a strip club?", "First Impression of your partner.", "Did either of you, for any amount of time think, they might be of a differing sexual orientation?", "Are you intimidated by any of your partner's friends? And if so, who?", "Are you possessinve about your partner or the relationship?", "What's your dream date?", "Describe your idea of a horrible date?", "How much would you pay for a night with your partner if you weren't together?", "How would you feel about your partner having an OnlyFans?", "What was the biggest surprise of the relationship?", "Have you ever lied to your partner?", "Who's on your 'free pass' ?", "Name one thing you're too shy to do in your relationship.", "Have you ever farted in front of your partner?", "What's the most unique thing about your partner?", "Who's the more sexual person in the relationship?", "Would you let your partner do your make-up?", "Are you usually the dumper or the dumpee?", "What's the worst thing you'd exchange your partner for?", "Would you ever have a threesome?", "Did either of you think/want to get luckky on the first date?"]
