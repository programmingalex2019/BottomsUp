import 'package:bottoms_up/design/appcolors.dart';
import 'package:flutter/material.dart';

class TruthDareDirection extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;

  const TruthDareDirection({
    Key key,
    @required this.icon,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(width: 3.0, color: Colors.black87),
        ),
        child: Center(
          child: Icon(icon, size: 45.0, color: AppColors.tDgradientRed,),
        ),
      ),
    );
  }
}