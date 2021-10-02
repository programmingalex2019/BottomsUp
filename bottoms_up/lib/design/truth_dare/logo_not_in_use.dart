import 'package:bottoms_up/design/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';



// NOT IN USE 

class TruthDareLogo extends StatelessWidget {

  final double width;
  final double height;

  const TruthDareLogo({
    Key key,
    this.mediaQuery, this.width, this.height,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Transform.rotate(
        angle: -pi / 18,
        child: Stack(
          children: [
            Positioned(
              child: Transform.rotate(
                angle: pi / 13,
                child: SvgPicture.asset(
                  "assets/images/SVG/Halo.svg",
                  semanticsLabel: "Halo",
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              left: mediaQuery.size.width / 39,
              top: mediaQuery.size.height / 90,
              child: Container(
                child: Text(
                  'TRUTH',
                  style: TextStyle(
                    fontFamily: 'Gagalin',
                    color: Colors.white,
                    fontSize: mediaQuery.size.width / 6.0,
                    shadows: AppText.truthDareShadow,
                  ),
                ),
              ),
            ),
            Positioned(
              top: mediaQuery.size.width / 4.9,
              left: mediaQuery.size.width / 2.9,
              child: Text(
                'Or',
                style: TextStyle(
                  fontFamily: 'Bukhari',
                  color: Colors.white,
                  fontSize: 32,
                  shadows: AppText.truthDareShadow,
                ),
              ),
            ),
            Positioned(
              top: mediaQuery.size.width / 3.6,
              left: mediaQuery.size.width / 2.73,
              child: Transform.rotate(
                angle: pi / 20,
                child: SvgPicture.asset(
                  "assets/images/SVG/Horns.svg",
                  semanticsLabel: "Horns",
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: mediaQuery.size.width / 3.72,
              left: mediaQuery.size.width / 2.58,
              child: Text(
                'Dare',
                style: TextStyle(
                  fontFamily: 'Gagalin',
                  color: Colors.white,
                  fontSize: mediaQuery.size.width / 5.6,
                  shadows: AppText.truthDareShadow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}