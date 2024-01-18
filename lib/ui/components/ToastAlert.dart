import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastAlert{
  ToastAlert();

  void showToastAlert(String msg, bool type){
    Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: type ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
  }
}