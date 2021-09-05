import 'dart:math';

import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player.dart';
import 'package:bottoms_up/services/data_request.dart';
import 'package:flutter/widgets.dart';

class SpinTheBottleManager extends ChangeNotifier {


  List<SpinBottlePlayer> players = [];
  bool moreThanOne = false;
  bool showedInitialPopUp = false;
  SpinBottlePlayer challenger;
  SpinBottlePlayer challengee; 
  String challenge = "";

  void addPlayer(SpinBottlePlayer spinBottlePlayer, int index){
    players.insert(index, spinBottlePlayer);
    if(players.length >= 2) moreThanOne = true;
    notifyListeners();
  }

  SpinBottlePlayer removePlayer(int index){
    SpinBottlePlayer spinTheBottlePlayer = players.removeAt(index);
    if(players.length < 2) moreThanOne = false;
    for(SpinBottlePlayer i in players) print(i.name);
    notifyListeners();
    return spinTheBottlePlayer;
  }

  String validator(String input) {

    for(SpinBottlePlayer i in players){
      if(i.name.compareTo(input) == 0){
        return "This name has been already selected";
      }
    }

    if (input.isEmpty) {
      return "Please enter a name";
    } else if (input.length > 12) {
      return "The name must be less than 12 characters";
    } 
    return null;
  }

  void resetSpinBottlePlayers(){
    players = [];
    moreThanOne = false;
  }

  void validPlayerSize(){
    if(players.length > 1){
      moreThanOne = false;
      notifyListeners();
    }
  }

  //spinBottleGame
  void showedInitialPopUpF(){
    showedInitialPopUp = true;
    notifyListeners();
  }
  void resetSpinBottleGame(){
    showedInitialPopUp = false;
    challenger = null;
    challengee = null;
    notifyListeners();
  }

  //get randomPlayers
  void getInitialRandomPlayer(){
    players.shuffle(); //shuffle deck
    //generate random index
    Random random = new Random();

    int challengerI = random.nextInt(players.length); //range is the list size

    challenger = players[challengerI];

    notifyListeners();
  }

  void getRandomPlayers(){

    players.shuffle(); //shuffle deck
    //generate random index
    Random random = new Random();
    
    int challengerI = random.nextInt(players.length); //range is the list size
    int challengeeI = challengerI;


    do{

      challengeeI = random.nextInt(players.length);

    } while(challengeeI == challengerI);


    challenger = players[challengerI];
    challengee = players[challengeeI];

    notifyListeners();

  }
  
  //getData 
  void getChallenge(List<String> challenges){

    challenges.shuffle(); //never start with same challenge

    challenge = challenges.last;

    challenges.removeLast(); //remove / will be reloaded later

    notifyListeners();

  }


}
