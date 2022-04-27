import 'package:flutter/material.dart';
import 'package:Wallet/Constants/ColorConstants.dart';
import 'package:another_flushbar/flushbar.dart';

class ToastUtil {
  void showMsg(context, msg, bgColor, txtColor, fontSize, String length,
      String gravity) {
    Flushbar(
      title: "Hey Ninja",
      message:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
