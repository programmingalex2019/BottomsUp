import 'package:bottoms_up/screens/games/kindsCup/kings_card.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class KingsCupManager extends ChangeNotifier {


  String card = "King's-Cup";
  String challenge = "Drink Responsibly";
  bool cardViewLoaded = false;
  

  void changeCard(String cardData){
    card = cardData;
    notifyListeners();
  }

  void changeChallenge(String challengeData){
    challenge = challengeData;
    notifyListeners();
  }

  bool foundKing(String currentCard){

    if(currentCard.toLowerCase().contains("king")){
      return true;
    }
    return false;  
    
  }

  void setLoaded(){
    cardViewLoaded = true;
    notifyListeners();
  }

  void reset(){
    card = "King's Cup";
    challenge = "Drink Responsibly";
    cardViewLoaded = false;
    notifyListeners();
  }

 


  //generate 52 KingsCards
  List<KingsCard> generateKingsCards(List<KingsCardData> challenges, List<PlayingCard> cards){

    List<KingsCard> kingsCards = [];

    for(int i = 0; i < cards.length; i++){ //52


      kingsCards.add(new KingsCard(card: cards[i], challenge: challenges[i].challenge, cardTitle: challenges[i].card));


      // print("Current card: ${cards[i].suit} ${cards[i].value}");
      // print("Current challenge ${challenges[i]}");

    }

    

    return kingsCards;

  }


}