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
    return Container(
      width: 200,
      height: 80,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 5.0),
        color: Colors.white,
      ),
      child: Center(child: Text(content, style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}