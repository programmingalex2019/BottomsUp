import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';

class SpinBottleGameCard extends StatelessWidget {
  final Color borderColor;
  final String content;

  const SpinBottleGameCard({
    Key key,
    this.borderColor,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Container(
      width: SizeConfig.blockSizeHorizontal * 50,
      height: SizeConfig.blockSizeVertical * 10,
      margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3),
        border: Border.all(color: borderColor, width: SizeConfig.safeBlockHorizontal * 1),
        color: Colors.white,
      ),
      child: Center(child: Text(content, style: TextStyle(color: Colors.black, fontSize: SizeConfig.safeBlockHorizontal * 5, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}