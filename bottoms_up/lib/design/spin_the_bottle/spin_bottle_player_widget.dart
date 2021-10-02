import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';

class SpinBottlePlayerWidget extends StatelessWidget {

  final String player;
  final Animation animation;
  final VoidCallback onClicked;

  const SpinBottlePlayerWidget({
    @required this.player,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5),
          child: Container(
            margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.5, horizontal: SizeConfig.safeBlockHorizontal * 3),
                title: Text(player, style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5, fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: SizeConfig.safeBlockHorizontal * 7),
                  onPressed: onClicked,
                ),
              ),
            ),
          ),
        ),
      );

  }
}