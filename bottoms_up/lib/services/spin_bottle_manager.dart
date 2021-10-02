import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class SpinTheBottleManager extends ChangeNotifier {

  List<String> players = [];
  bool moreThanOne = false;
  bool showedInitialPopUp = false;
  String challenger;
  String challengee;
  String challenge = "Initial";

  Map<String, Set<List<String>>> tupples = Map();

  //add player to list of players
  void addPlayer(String spinBottlePlayer, int index) {

    players.insert(index, spinBottlePlayer);
    if (players.length >= 2) moreThanOne = true;
    notifyListeners();

  }

  //remove player from list of players
  String removePlayer(int index) {

    String spinTheBottlePlayer = players.removeAt(index);
    if (players.length < 2) moreThanOne = false;
    notifyListeners();
    return spinTheBottlePlayer;

  }

  //check whether player valid for the list 
  String validator(String input) {

    for (String i in players) {
      if (i.compareTo(input) == 0) {
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

  //if exited players scren
  void resetSpinBottlePlayers() {
    players = [];
    moreThanOne = false;
    notifyListeners();
  }

  void validPlayerSize() {
    if (players.length > 1) {
      moreThanOne = false;
      notifyListeners();
    }
  }

  //used after runned out of combinations 
  void resetShowedInitialPopUp(){
    showedInitialPopUp = false;
  }

  //after first pop shown
  void showedInitialPopUpF() {
    showedInitialPopUp = true;
    notifyListeners();
  }

  //when exited spin the bottle game
  void resetSpinBottleGame() {
    showedInitialPopUp = false;
    challenger = null;
    challengee = null;
    notifyListeners();
  }


  //get Combinations 
  void getChallenge(Map<String, Set<List<String>>> challenges) {

    //get random key and assign it's name to current challenge 
    String key = challenges.keys.elementAt( Random().nextInt(challenges.length) ); 
    challenge = key; //assign to challenge

    // int 
    int challengerI;
    int challengeeI;

    do {
      challengerI = Random().nextInt(challenges[key].last.length);
      challengeeI = Random().nextInt(challenges[key].last.length);
    } while (challengeeI == challengerI);

    //assign player name according to key 
    challenger = challenges[key].last[challengerI]; 
    challengee = challenges[key].last[challengeeI]; 

    //a way to pop list from set
    challenges[key].last.clear();
    challenges[key].removeWhere((element) => element.isEmpty);

    //remove combination if no more combinations in a set
    if(challenges[key].length == 0) {
      challenges.remove(key);
    }

    notifyListeners();

  }
}
