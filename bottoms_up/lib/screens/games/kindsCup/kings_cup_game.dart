import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/screens/games/kindsCup/kings_card.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:bottoms_up/services/kings_cup_manager.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class KingsCupGame extends StatefulWidget {
  @override
  _KingsCupGameState createState() => _KingsCupGameState();
}

class _KingsCupGameState extends State<KingsCupGame> {

  Future<List<KingsCard>> _dbKingsCards; //CardsData 52 + placeholder

  List<PlayingCardView> cardViews = []; //CardViews 52 + intro card

  int foundKings = 0; // important data -> 4 kings found -> game restarts

  PlayingCardViewStyle myCardStyles = AppBase.introCardStyle(); //intro Card Style

  List<PlayingCardView> _foundKings = AppBase.fourKings(); //list of PlayingCardViews (copy) -> to manipulate

  //future builder data
  Future<List<KingsCard>> _getChallenges() async {
  
    KingsCupManager kingsCupManager = Provider.of<KingsCupManager>(context, listen: false);

    List<KingsCardData> kingsCarddata = await DataRequest().getKingsCupData(); //list of strings (challenges)

    List<KingsCard> shuffled = kingsCupManager.generateKingsCards(kingsCarddata, standardFiftyTwoCardDeck()); //list of 52 cards

    shuffled.shuffle();

    if (kingsCupManager.foundKing(shuffled[shuffled.length - 1].card.value.toString())) {
      //if king is found to be top of stack -> reveal it in found kings (king pointer moved to 2)

      _foundKings[foundKings] = PlayingCardView(card: shuffled[shuffled.length - 1].card, showBack: false); //if king happens to be first time

    }

    shuffled.add(KingsCard(card: PlayingCard(Suit.spades, CardValue.king), challenge: "Placeholder")); //place holder -> wont be shown -> hallenge will come from manager, and cardView would be an intro card actual cards with challenges will appear from the first swipe.

    return shuffled;
  }

  @override
  void initState() {
    _dbKingsCards = _getChallenges(); //future builder
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    final KingsCupManager kingsCupManager = Provider.of<KingsCupManager>(context, listen: false); //manager

    print(mediaQuery.size.width);
    print(mediaQuery.size.height);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              decoration: BoxDecoration(
                gradient: AppColors.kingsCupGradient, //background color
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppBase.appPopIcon(context, () {
                      kingsCupManager.reset();
                      Navigator.pop(context);
                    }, 15.0, 15.0, 15.0),
                    Padding(
                      padding: EdgeInsets.only(right: mediaQuery.size.width / 13.71),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: mediaQuery.size.width / 2.4,
                            height: mediaQuery.size.height / 14,
                            child: FlatCardFan(children: _foundKings), // 4 kings top right corner
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<KingsCard>>(
                      future: _dbKingsCards, //firebase data
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Expanded(child: AppBase.loadingLottie);
                            break;
                          default:
                            if (snapshot.hasError) //comes from custom throw exception
                              return Text('${snapshot.error}');
                            else if (snapshot.data == null)
                              return Text('${snapshot.error}');
                            else {
                              //code will run once
                              if (snapshot.data.length != 2 && kingsCupManager.cardViewLoaded == false) {
                                for (int i = 0; i < snapshot.data.length - 1; i++) {
                                  // -1 because placeholder added for kingsCards
                                  if (i != snapshot.data.length - 1 || i != snapshot.data.length - 2) // -2 included since in the beggining placeholder card
                                    cardViews.add(PlayingCardView(card: snapshot.data[i].card, showBack: true));
                                  else
                                    cardViews.add(PlayingCardView(card: snapshot.data[i].card, showBack: false));
                                }
                                //intro card
                                cardViews.add(PlayingCardView(card: PlayingCard(Suit.spades, CardValue.king), showBack: false,style: myCardStyles));
                              }
                              //code will run once

                            }

                            return Container(
                                width: mediaQuery.size.width / 1.05,
                                height: mediaQuery.size.height / 1.9,
                                child: SwipeStack(
                                  children: cardViews.map(
                                    (PlayingCardView card) {
                                      return SwiperItem(
                                        builder: (SwiperPosition position,
                                            double progress) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: mediaQuery.size.width / 20.57, right: mediaQuery.size.width / 20.57, top: mediaQuery.size.width / 20.57),
                                            child: card,
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                  visibleCount: 3,
                                  stackFrom: StackFrom.Bottom,
                                  translationInterval: 12,
                                  scaleInterval: 0.03,
                                  onEnd: () {},
                                  onSwipe: (int index, SwiperPosition position) {
                                    setState(() {

                                      snapshot.data.removeLast(); //remove kings card
                                      snapshot.data.shuffle(); //shuffle kings cards
                                      kingsCupManager.setLoaded(); //so no more cardViews generated
                                      cardViews.removeLast();

                                      //once above executed -> receive next card and manipulate UI
                                      KingsCard currentCard = snapshot.data[snapshot.data.length - 1]; //current card is top of stack

                                      String value = currentCard.card.value.toString().split(".")[1];
                                      String suit = currentCard.card.suit.toString().split(".")[1];

                                      kingsCupManager.changeCard("$value of $suit");
                                      kingsCupManager.changeChallenge(currentCard.challenge.toString());

                                      //top card
                                      cardViews[cardViews.length - 1] = PlayingCardView(card: currentCard.card, showBack: false);

                                      //found kings
                                      if (kingsCupManager.foundKing(currentCard.challenge)) {
                                        
                                        foundKings++;
                                        // four little cards
                                        _foundKings[foundKings - 1] = PlayingCardView(card: snapshot.data[snapshot.data.length - 1].card, showBack: false); //0 1 2 3

                                        if (foundKings == 4) {

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              // title: Text("Congratulations you filthy twat, now drink everything"),
                                              
                                              backgroundColor: AppColors.kCgradientLightGreen,
                                              content: Container(
                                                width: mediaQuery.size.width / 2,
                                                height: mediaQuery.size.height / 4,
                                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:CrossAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      "CONGRATS!",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "Shrikhand",
                                                        fontSize: mediaQuery.size.width / 15,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 2,
                                                        color: Colors.yellowAccent,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: mediaQuery.size.height / 52),
                                                      child: AutoSizeText(
                                                        "NOW DRINK EVERYTHING TWAT.",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: "Shrikhand",
                                                          fontSize: mediaQuery.size.width / 22,
                                                          letterSpacing: 1,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: mediaQuery.size.height / 45),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment:CrossAxisAlignment.center,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {

                                                                Navigator.pop(context);

                                                                setState(() {
                                                                  _dbKingsCards = _getChallenges(); //reload challenges
                                                                  kingsCupManager.reset(); //reset UI components
                                                                  foundKings = 0;
                                                                  cardViews = []; //to avoid dublication
                                                                  _foundKings = AppBase.fourKings(); //list of four kings
                                                                });

                                                              },
                                                              child: Icon(Icons.restore, size: mediaQuery.size.width / 10, color: AppColors.kCpopUpdarkGreen),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                                
                                                                Navigator.popUntil(context, (route) => route.isFirst);

                                                              },
                                                              child: Icon(Icons.exit_to_app, size: mediaQuery.size.width / 10, color: AppColors.kCpopUpdarkGreen),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ).then((value) {
                                            setState(() {

                                              _dbKingsCards = _getChallenges(); //reload challenges
                                              kingsCupManager.reset(); //reset UI components
                                              foundKings = 0;
                                              cardViews = []; //to avoid dublication
                                              _foundKings = AppBase.fourKings(); //list of four kings

                                            });
                                          });
                                        }
                                      }
                                      // }
                                    });
                                  },
                                  onRewind: (int index, SwiperPosition position) => debugPrint("onRewind $index $position"),
                                )

                                // child: KingsCupCardGame(deck: cards, mediaQuery: mediaQuery),
                            );
                          // snapshot.data;
                        }
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: mediaQuery.size.width / 8.22),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(mediaQuery.size.width / 20.57),
                                topRight: Radius.circular(mediaQuery.size.width / 20.57),
                                bottomLeft: Radius.elliptical(mediaQuery.size.width / 8.22, mediaQuery.size.width / 4.11),
                                bottomRight: Radius.elliptical(mediaQuery.size.width / 8.22, mediaQuery.size.width / 4.11),
                                ),
                            color: AppColors.kCpopUpdarkGreen,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 10,
                                  blurRadius: 10),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: mediaQuery.size.width / 13.71),
                            child: Container(
                              width: mediaQuery.size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(
                                    kingsCupManager.card,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Monoton",
                                        fontSize: mediaQuery.size.width / 13.71),
                                  ),
                                  AutoSizeText(
                                    kingsCupManager.challenge,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Shrikhand",
                                        fontSize: mediaQuery.size.width / 14.71),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
