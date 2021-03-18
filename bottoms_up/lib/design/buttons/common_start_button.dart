import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';

class BottomsUpButton extends StatelessWidget {

  final width;
  final height;
  final iconSize;
  final VoidCallback function;
  final Color shadowColor;
  final Color iconColor;

  const BottomsUpButton({
    Key key, this.width, this.iconColor, this.height, this.iconSize, this.function, this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FButton(
      width: width,
      height: height,
      color: Colors.white,
      onPressed: function,
      clickEffect: true,
      shadowColor: shadowColor ?? null,
      shadowOffset: Offset(2, 2),
      highlightColor: Colors.white,
      shadowBlur: 5,
      corner: FCorner.all(50),
      image: Container(
        child: Icon(
          Icons.play_arrow_rounded,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}