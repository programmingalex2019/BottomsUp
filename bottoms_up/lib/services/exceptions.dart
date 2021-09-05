import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class CustomExceptionMessage {

  final String message; 

  CustomExceptionMessage(this.message);

  @override 
  String toString() => message;

}

class CustomException {

  static Future<T> tryFunction<T>(Future<T> Function() function) async{

    try{

      return await function();

    } on SocketException {

      throw CustomExceptionMessage("No Internet Connection");

    } on HttpException {

      throw CustomExceptionMessage("Could not find data");

    } on FormatException {

      throw CustomExceptionMessage("Bad response format");

    } on PlatformException {

      throw CustomExceptionMessage("Something went wrong");
    }
    on FirebaseException {
      throw CustomExceptionMessage("Something went wrong");
    }

  }


}