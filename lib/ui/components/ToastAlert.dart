import 'package:blife_test/utils/colors.dart';
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
      backgroundColor: type ? GreenColor : RedColor,
      textColor: WhiteColor,
      fontSize: 16.0
    );
  }
}