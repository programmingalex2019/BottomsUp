import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/services/truth_dare_manager.dart';
import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TruthDareStartCardsButton extends StatefulWidget {
  final width;
  final height;
  final iconSize;
  final VoidCallback function;

  const TruthDareStartCardsButton({
    Key key,
    this.width,
    this.height,
    this.iconSize,
    this.function,
  }) : super(key: key);

  @override
  _TruthDareStartCardsButtonState createState() =>
      _TruthDareStartCardsButtonState();
}

class _TruthDareStartCardsButtonState extends State<TruthDareStartCardsButton>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    var truthDareManager =
        Provider.of<TruthDareManager>(context, listen: false);

    var data = Provider.of<TruthDareManager>(context, listen: false);

    data.oneTrue
        ? animationController.forward()
        : animationController.reverse();

    print("One True ${truthDareManager.oneTrue}");

    return FButton(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      onPressed: () {},
      clickEffect: true,
      shadowColor: AppColors.tDgradientRed,
      shadowOffset: Offset(2, 2),
      highlightColor: Colors.white,
      shadowBlur: 5,
      corner: FCorner.all(50),
      image: AnimatedIconButton(
        animationController: animationController,
        size: 35,
        onPressed: () {
          truthDareManager.oneTrue
              ? Navigator.pushNamed(context, "/truth_dare_cards")
              : null;
        },
        endIcon: Icon(
          Icons.play_arrow,
          color: AppColors.truthDareButtonIcon,
        ),
        startIcon: Icon(
          Icons.stop,
          color: AppColors.truthDareButtonIcon,
        ),
      ),
    );
  }
}

