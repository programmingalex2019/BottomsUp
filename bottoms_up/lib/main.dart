import 'package:bottoms_up/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
Future<void> main() async{
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
