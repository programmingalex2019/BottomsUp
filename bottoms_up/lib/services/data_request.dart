import 'package:cloud_firestore/cloud_firestore.dart';

class DataRequest {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //request will be a list of modes 
  Future<List<List<String>>> getTruthDareData(List<String> request) async {

    //transforming the list into the correct format
    List<String> divided = [];
    
    for(String i in request){
      //[Party,Dirty] 
      divided = i.split(",");
    }
  
    List<List<String>> allQuestions = []; //will contain dare and truth lists
    List<String> dareQuestions = [];
    List<String> truthQuestions = [];

    //depending on type get truth or dare questions
    var dareResults = await _firestore
        .collection("users/truth-dare/truth-dare")
        .where("type", whereIn: divided)
        .get((GetOptions(source: Source.server))); // dont get data from cache

    var truthResults = await _firestore
        .collection("users/truth-dare/truth-dare")
        .where("type", whereIn: divided)
        .get(GetOptions(source: Source.server)); // dont get data from cache

    dareResults.docs.forEach(
      (res) {
        for (String i in res.data()["dare"]) {
          dareQuestions.add(i);
        }
      },
    );

    truthResults.docs.forEach(
      (res) {
        for (String i in res.data()["truth"]) {
          truthQuestions.add(i);
        }
      },
    );

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

      for(String i in element.data()["questions"]){
        headsTailsQuestionsList.add(i);
      }

    });

    await Future.delayed(Duration(seconds: 1));

    return headsTailsQuestionsList;


  }


}
