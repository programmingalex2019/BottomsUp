import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/services/spin_bottle_manager.dart';
import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpinTheBottleStartButton extends StatefulWidget {

  final width;
  final height;
  final iconSize;
  // final VoidCallback function;

  const SpinTheBottleStartButton({
    Key key,
    this.width,
    this.height,
    this.iconSize,
    // this.function,
  }) : super(key: key);

  @override
  _SpinTheBottleStartButtonState createState() =>
      _SpinTheBottleStartButtonState();
}

class _SpinTheBottleStartButtonState extends State<SpinTheBottleStartButton>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
      reverseDuration: Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {

    SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);

    spinTheBottleManager.moreThanOne ? animationController.forward() : animationController.reverse();

    // print("One True ${truthDareManager.oneTrue}");

    return FButton(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      onPressed: () {},
      clickEffect: true,
      shadowColor: Colors.black38,
      shadowOffset: Offset(1, 1),
      shadowBlur: 5,
      corner: FCorner.all(50),
      image: AnimatedIconButton(
        animationController: animationController,
        size: widget.iconSize,
        onPressed: () {
          spinTheBottleManager.moreThanOne
              ? Navigator.pushNamed(context, "/spin_the_bottle_game") //change to spinBottleScreen
              : null;
        },
        startIcon: Icon(
          Icons.stop,
          color: AppColors.truthDareButtonIcon,
        ),
        endIcon: Icon(
          Icons.play_arrow,
          color: AppColors.truthDareButtonIcon,
        ),
      ),
    );
  }
}