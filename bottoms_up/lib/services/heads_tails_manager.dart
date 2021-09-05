import 'package:flutter/widgets.dart';

import 'dart:math';

class HeadsTailsManager extends ChangeNotifier {

  String defaultCointText = "Toss Me";
  String currentGameType = "Never Have I Ever";
  String currentQuestion = "Swipe Me";

  int createRandom(){
    return Random().nextInt(2); // 0 or 1
  }
  //toss coin
  String getHeadsOrTails(int random){
    return random > 0 ? "HEADS" : "TAILS";
  }
  //coin text
  void assignText(){
    defaultCointText = getHeadsOrTails(createRandom());
    notifyListeners();
  }
  //on swipe card
  void reasignText(){
    defaultCointText = "Toss Me";
    notifyListeners();
  }
  //during animation
  void duringTossText(){
    defaultCointText = " ";
    notifyListeners();
  }

  void setDefault(){
    currentQuestion = "Swipe Me";
  }


  //cards screen
  void shuffleAndReturn(List<String> typeQuestions) {

    typeQuestions.shuffle(); //shuffle deck
    //generate random index
    Random random = new Random();
    int which = random.nextInt(typeQuestions.length); //range is the list size
    print(which);

    //assign currentQuestion to be...
    currentQuestion = typeQuestions[which];

    //avoid repetition mechanics 
    typeQuestions.removeAt(which);

    notifyListeners();
  }

}