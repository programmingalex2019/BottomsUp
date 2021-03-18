import 'package:bottoms_up/design/appcolors.dart';
import 'package:flutter/material.dart';

class SwipeAppCard extends StatelessWidget {

  //colors
  final Color borderColor;
  //Content
  final String currentGameType; //if needed
  final String currentCardType;
  final String currentQuestion;

  //textStyles
  final TextStyle currentQuestionTextStyle;
  final TextStyle currentCardTypeTextStyle;
  final TextStyle currentGameTypeTextStyle;

  const SwipeAppCard({
    Key key,
    this.borderColor,
    this.currentGameType,
    this.currentCardType,
    @required this.currentQuestion, 
    this.currentQuestionTextStyle, 
    this.currentCardTypeTextStyle, 
    this.currentGameTypeTextStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 7.0, color: borderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              currentCardType ?? "Some Type",
              textAlign: TextAlign.center,
              style: currentCardTypeTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Text(
                currentQuestion ?? "Some Question",
                textAlign: TextAlign.center,
                style: currentQuestionTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
              ),
              child: Row(
                children: [
                  Text(
                    currentGameType ?? " ", //not always needed
                    style: currentGameTypeTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
