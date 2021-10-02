import 'package:bottoms_up/screens/games/kindsCup/kings_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trotter/trotter.dart';


class DataRequest {
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //request will be a list of modes
  Future<List<List<String>>> getTruthDareData(List<String> request) async {
    //transforming the list into the correct format
    List<String> divided = [];

    for (String i in request) {
      //[Party,Dirty]
      divided = i.split(","); // need to transform from list to string
    }

    List<List<String>> allQuestions = []; //will contain dare and truth lists
    List<String> dareQuestions = [];
    List<String> truthQuestions = [];
    var dareResults;
    var truthResults;

    //depending on type get truth or dare questions
    dareResults = await _firestore
        .collection("users/truth-dare/truth-dare")
        .where("type", whereIn: divided)
        .get((GetOptions(source: Source.server))); // dont get data from cache

    truthResults = await _firestore
        .collection("users/truth-dare/truth-dare")
        .where("type", whereIn: divided)
        .get(GetOptions(source: Source.server)); // dont get data from cache

    //need to get value from each key (dare results stores objects)
    dareResults.docs.forEach(
      (res) {
        for (String i in res.data()["dare"]) {
          dareQuestions.add(i); //add dare strings
        }
      },
    );

    truthResults.docs.forEach(
      (res) {
        for (String i in res.data()["truth"]) {
          truthQuestions.add(i); //add truth strings
        }
      },
    );

    //combine all of them
    allQuestions.add(dareQuestions);
    allQuestions.add(truthQuestions);

    //give a second for the animation
    await Future.delayed(Duration(seconds: 1));

    return allQuestions;
  }

  Future<List<String>> getHeadsTailsData() async {
    List<String> headsTailsQuestionsList = [];

    //firestore
    var headsTailsQuestions = await _firestore
        .collection("users/heads-tails/heads-tails")
        .get(GetOptions(source: Source.server));

    //string from questions key
    headsTailsQuestions.docs.forEach((element) {
      for (String i in element.data()["questions"]) {
        headsTailsQuestionsList.add(i); //add all data (strings)
      }
    });

    //give a second for the animation
    await Future.delayed(Duration(seconds: 1));

    return headsTailsQuestionsList;
  }

  Future<List<KingsCardData>> getKingsCupData() async {

    // List<String> cardChallenges = []; //list of strings


    QuerySnapshot data = await _firestore
        .collection("users/kings-cup/kings-cup")
        .get(GetOptions(source: Source.server));

  
    List<KingsCardData> kingsCardDataList = [];

    data.docs.forEach((element) {
      //each document
      

      KingsCardData kingsCardDataObject = KingsCardData.fromJson(element.data());

      kingsCardDataList.add(kingsCardDataObject);

    });


    kingsCardDataList.sort((b, a) => a.key.compareTo(b.key)); //sort descending

    //give a second for the animation
    await Future.delayed(Duration(seconds: 1));

    return kingsCardDataList; //list of sorted 


  }

  //WARNING: relies 
  Future<Map<String, Set<List<String>>>> getSpinTheBottleData(List<String> players) async {

    List<String> spinTheBottleQuestionsList = [];

    Map<String, Set<List<String>>> combinations;

    //firestore
    try{
      var spinTheBottleQuestions = await _firestore
          .collection("users/spin-bottle/spin-bottle")
          .get(GetOptions(source: Source.server));
      
    //string from questions key
      spinTheBottleQuestions.docs.forEach((element) {
        for (String i in element.data()["questions"]) {
          spinTheBottleQuestionsList.add(i); //add all data (strings)
        }
      });


      spinTheBottleQuestionsList.shuffle();
      //returns a map of keys for each question and an empty set for each
      combinations = Map.fromIterable(spinTheBottleQuestionsList, key: (item) => item, value: (item) => {});
      //for each key add possible combinations -> will be shuffled after 
      combinations.forEach((key, value) {
        
        final permutations = players, perms = Permutations(2, players);

        for (final permutation in perms()) {

          // permutation.shuffle();
          combinations[key].add(permutation);
          
        }

        players.shuffle();

      });

  

    }catch(e){
      print(e.toString());
    }
    

    //give a second for the animation
    await Future.delayed(Duration(seconds: 1));

    return combinations;
  }

}
