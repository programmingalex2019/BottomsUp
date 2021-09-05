import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/screens/home.dart';
import 'package:bottoms_up/services/heads_tails_manager.dart';
import 'package:bottoms_up/services/kings_cup_manager.dart';
import 'package:bottoms_up/services/routes.dart';
import 'package:bottoms_up/services/spin_bottle_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import 'services/truth_dare_manager.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TruthDareManager>(create: (context) => TruthDareManager()),
        ChangeNotifierProvider<HeadsTailsManager>(create: (context) => HeadsTailsManager()),
        ChangeNotifierProvider<KingsCupManager>(create: (context) => KingsCupManager()),
        ChangeNotifierProvider<SpinTheBottleManager>(create: (context) => SpinTheBottleManager()),
      ],
      child: PlatformApp(), //cross platform app //orientation Portrait //TODO: set orientation for IOS 
    );
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: AppBase.splashScreen, //custom splashScreen
        onGenerateRoute: Routes.cupertinoPageRoutes, //named routes
      );
    } else {
      //Android
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        onGenerateRoute: Routes.materialPageRoutes,
      );
    }
  }
}
