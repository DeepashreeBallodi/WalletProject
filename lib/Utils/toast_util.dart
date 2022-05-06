import 'package:Wallet/Constants/color_constants.dart';
import 'package:Wallet/Constants/text_styles.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  /* Singleton Class */
  static ToastUtil _toastUtilInstance = new ToastUtil._internal();
  ToastUtil._internal();
  factory ToastUtil() => _toastUtilInstance;

  void showMsg(
    context,
    msg,
  ) {
    if (msg != null && msg != "") {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Text(
          msg,
          textAlign: TextAlign.center,
          style: FontTextStyle().titBlackTextStyle(),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.blue,
      )..show(context);
    }
  }
}
