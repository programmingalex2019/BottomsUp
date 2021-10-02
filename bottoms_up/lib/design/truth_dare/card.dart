import 'package:bottoms_up/services/size_config.dart';
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
    this.currentQuestion, 
    this.currentQuestionTextStyle, 
    this.currentCardTypeTextStyle, 
    this.currentGameTypeTextStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(
        Radius.circular(SizeConfig.blockSizeHorizontal * 3),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: SizeConfig.blockSizeHorizontal * 2, color: borderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeHorizontal * 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 13),
              child: Text(
                currentCardType ?? "Some Type",
                textAlign: TextAlign.center,
                style: currentCardTypeTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 8,
              ),
              child: Text(
                currentQuestion ?? "Some Question",
                textAlign: TextAlign.center,
                style: currentQuestionTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 5,
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
