import 'package:bottoms_up/design/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

Widget _home;
String _imagePath;
int _duration;
Color _backgroundColor;
String text;

class SplashScreen extends StatefulWidget {
  SplashScreen(
      {@required String imagePath,
      @required Widget home,
      Function customFunction,
      int duration,
      Color backgroundColor,
      Map<dynamic, Widget> outputAndHome}) {
    _home = home;
    _duration = duration;
    _imagePath = imagePath;
    _backgroundColor = backgroundColor;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    //wait and go to other screen

    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      print('start');
      _animationController.forward();
      Future.delayed(Duration(milliseconds: _duration)).then((value) {
        Navigator.of(context).pushReplacementNamed('/landing');
      });
    });

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width / 7,
                top: MediaQuery.of(context).size.height / 3.5,
                child: Transform.rotate(
                  angle: -pi / 10,
                  child: Text(
                    'Bottoms',
                    textAlign: TextAlign.center,
                    style: AppText.splashFont,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3.3,
                top: MediaQuery.of(context).size.height / 2.6,
                child: Transform.rotate(
                  angle: -pi / 10,
                  child: Text(
                    '  Up!',
                    textAlign: TextAlign.center,
                    style: AppText.splashFont,
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 2) + 5,
                left: (MediaQuery.of(context).size.width / 4) + 4,
                child: Opacity(
                  opacity: 0.5,
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset(
                      _imagePath,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 4,
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Image.asset(_imagePath),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
