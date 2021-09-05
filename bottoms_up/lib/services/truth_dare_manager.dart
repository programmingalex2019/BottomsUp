import 'dart:math';

import 'package:flutter/widgets.dart';

class TruthDareManager extends ChangeNotifier {

  List<String> questions = []; //list of all questions types to require

  //questionsType
  bool party = false; 
  bool dirty = false;
  bool couples = false;

  bool oneTrue = false;   //check if above has one true

  String currentQuestion = "Swipe Left for Dare. Swipe Right for Truth";   //initial question of the cards
  //initial card game type
  String currentCardType = "";
  //initial game type
  String currentGameType = "";

  //for truthDareModeButton => if Party clicked returns party bool
  bool isTypeSelected(String type) {
    if (type == "Party") {
      return party;
    }
    if (type == "Dirty") {
      return dirty;
    }
    if (type == "Couples") {
      return couples;
    }
  }

  //either truth or dare
  void setCurrentCardType(String currentType){
    currentCardType = currentType;
  }
  
  //party dirty or couples 
  void setCurrentGameType(String gameType){
    currentGameType = gameType;
  }

  //whenever pop from the screen set everything to false 
  void resetAllType(){
    party = false;
    dirty = false;
    couples = false;
    oneTrue = false;
    notifyListeners();
  }

  //for truthDareModeButton => to toggle between selected and not selected -> either true or false-> UI rebuilds
  void changeType(String type) {
    if (type == "Party") {
      party = !party;
      notifyListeners();
    }
    if (type == "Dirty") {
      dirty = !dirty;
      notifyListeners();
    }
    if (type == "Couples") {
      couples = !couples;
      notifyListeners();
    }

    checkIfOneTrue(); //everytime you click on a mode in mode screen check if one true
  }

  //used to work with the truthDareStartCardsButton UI
  void checkIfOneTrue() {
    if (party == true || dirty == true || couples == true) {
      oneTrue = true;
    } else {
      oneTrue = false;
    }

    notifyListeners();
  }

  void updateQuestions() {
    
    //just party 
    party && !couples && !dirty ? questions.add("Party") : questions.contains("Party") ? questions.remove("Party") : null;
    
    //just dirty 
    dirty && !party && !couples ? questions.add("Dirty") : questions.contains("Dirty") ? questions.remove("Dirty") : null;

    //party and dirty 
    couples && !party && !dirty ? questions.add("Couples") : questions.contains("Couples") ? questions.remove("Couples") : null;

    //party + dirty
    party && dirty && !couples ? questions.add("Party,Dirty") : questions.contains("Party,Dirty") ? questions.remove("Party,Dirty") : null;

    //party + couples 
    party && couples && !dirty ? questions.add("Party,Couples") : questions.contains("Party,Couples") ? questions.remove("Party,Couples") : null;

    //dirty + couples
    dirty && couples && !party ? questions.add("Dirty,Couples") : questions.contains("Dirty,Couples") ? questions.remove("Dirty,Couples") : null;

    //party + dirty + couples
    party && dirty && couples ? questions.add("Party,Dirty,Couples") : questions.contains("Party,Dirty,Couples") ? questions.remove("Party,Dirty,Couples") : null;
    
    notifyListeners();
  }


  //cards screen
  void shuffleAndReturn(List<String> typeQuestions) {

    typeQuestions.shuffle(); //shuffle deck
    //generate random index
    Random random = new Random();
    
    int which = (typeQuestions.length - 1 > 1) ? random.nextInt(typeQuestions.length - 1) : 0; //range is the list size

    //assign currentQuestion to be...

    if(typeQuestions.length > 0){
      currentQuestion = typeQuestions[which];
      print(currentQuestion);
      typeQuestions.removeAt(which);
    }
 
    print("Strings left: ${typeQuestions.length}");

    notifyListeners();
  }

  //used to have first card with this text
  void updateCurrentQuestionAndCardType() {
    currentQuestion = "Swipe Left for Dare. Swipe Right for Truth";
    currentCardType = " ";
    currentGameType = " ";
    notifyListeners();
  }


  //once truth or dare run out
  void drinkResponsibly(){
    currentQuestion = "Drink Responsiby";
    currentCardType = "Bottoms Up";
    currentGameType = "18+";
    notifyListeners();
  }

  void cardContentManagement({int truthOrDare, TruthDareManager manager, AsyncSnapshot<List<List<String>>> snapshot, String currentCardType, VoidCallback reload}) {

    manager.shuffleAndReturn(snapshot.data[truthOrDare]); //get questions from dare/truth stack
    manager.setCurrentCardType(currentCardType); //set current card type
    manager.setCurrentGameType(manager.questions[0]); //set current game mode

    //when run out of questions
    reload();
  }

  
}
