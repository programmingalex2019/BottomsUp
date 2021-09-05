import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player.dart';
import 'package:flutter/material.dart';

class SpinBottlePlayerWidget extends StatelessWidget {

  final SpinBottlePlayer player;
  final Animation animation;
  final VoidCallback onClicked;

  const SpinBottlePlayerWidget({
    @required this.player,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                title: Text(player.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 32),
                  onPressed: onClicked,
                ),
              ),
            ),
          ),
        ),
      );
}