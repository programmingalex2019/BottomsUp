import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:flutter/material.dart';

class TruthDareDirection extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;

  const TruthDareDirection({
    Key key,
    this.icon,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return GestureDetector(
      onTap: function,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 18,
        height: SizeConfig.blockSizeHorizontal * 18,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 28),
          border: Border.all(width: SizeConfig.blockSizeHorizontal * 0.8, color: Colors.black87),
        ),
        child: Center(
          child: Icon(icon, size: SizeConfig.blockSizeHorizontal * 11, color: AppColors.tDgradientRed,),
        ),
      ),
    );
  }
}