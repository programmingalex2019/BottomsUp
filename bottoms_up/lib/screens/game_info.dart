import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
  final String gameName;
  final String gameDescription;

  const GameInfo({
    Key key,
    this.gameName,
    this.gameDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: mediaQuery.size.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 7.0, color: Colors.black87),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        gameName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mediaQuery.size.height / 25,
                          color: AppColors.tDgradientRed,
                          fontFamily: "Bukhari",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.height / 25, vertical: 0),
                      child: AutoSizeText(
                        gameDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: mediaQuery.size.height / 5,
                          height: 2,
                          color: Colors.black87,
                        ),
                      
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 6.0, 12.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.tDgradientRed,
                          size: mediaQuery.size.height / 25,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
