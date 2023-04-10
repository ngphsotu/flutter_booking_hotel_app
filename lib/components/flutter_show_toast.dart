import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast {
  void showToast(String title) {
    Fluttertoast.showToast(
      msg: title,
      fontSize: 17,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      timeInSecForIosWeb: 1,
    );
  }
}
