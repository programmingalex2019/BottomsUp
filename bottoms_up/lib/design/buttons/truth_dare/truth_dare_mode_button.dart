import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:bottoms_up/services/truth_dare_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TruthModeButton extends StatefulWidget {
  final String text;
  final VoidCallback updateState;

  const TruthModeButton({
    Key key,
    this.mediaQuery,
    this.text,
    this.updateState,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  _TruthModeButtonState createState() => _TruthModeButtonState();
}

class _TruthModeButtonState extends State<TruthModeButton> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    TruthDareManager truthDareManager = Provider.of<TruthDareManager>(context, listen: false);

    return GestureDetector(
      onTap: () {

        truthDareManager.changeType(widget.text);
        truthDareManager.updateQuestions();
        widget.updateState(); //update state of parent to update state of current

      },
      child: AnimatedContainer(
        margin: truthDareManager.isTypeSelected(widget.text) ? EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5, left: SizeConfig.blockSizeHorizontal * 0.5) : EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 0.5),
        duration: Duration(milliseconds: 150),
        curve: Curves.easeIn,
        width: SizeConfig.blockSizeHorizontal * 55.0,
        height: SizeConfig.blockSizeVertical * 10.0,
        decoration: BoxDecoration(
          color: truthDareManager.isTypeSelected(widget.text)
              ? AppColors.tDgradientRed
              : Colors.white,
          border: Border.all(
            width: SizeConfig.blockSizeHorizontal * 0.5,
            color: truthDareManager.isTypeSelected(widget.text)
                ? Colors.white
                : Color(0xFFd33523),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.safeBlockHorizontal * 2.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.tDgradientRed,
              blurRadius: 1.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: truthDareManager.isTypeSelected(widget.text)
                  ? Colors.white
                  : AppColors.tDgradientRed,
              fontFamily: 'Gagalin',
              fontSize: SizeConfig.safeBlockHorizontal * 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
