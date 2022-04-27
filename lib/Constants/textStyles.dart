import 'package:Wallet/Constants/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class FontTextStyle {
  TextStyle titTextStyle() {
    return TextStyle(
      letterSpacing: 1.2,
      height: 1.5,
      fontStyle: FontStyle.normal,
      fontSize: ScreenUtil().setSp(20.0),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  TextStyle subTitTextStyle() {
    return TextStyle(
        letterSpacing: 0.5,
        height: 1.5,
        fontStyle: FontStyle.normal,
        fontSize: ScreenUtil().setSp(14.0),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: AppFontFamily.fontHeebo);
  }

  TextStyle amountTextStyle() {
    return TextStyle(
        letterSpacing: 0.5,
        height: 1.5,
        fontStyle: FontStyle.normal,
        fontSize: ScreenUtil().setSp(30.0),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: AppFontFamily.fontSansation);
  }

  TextStyle basicTextStyle() {
    return TextStyle(
        letterSpacing: 0.5,
        height: 1.0,
        fontStyle: FontStyle.normal,
        fontSize: ScreenUtil().setSp(18.0),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: AppFontFamily.fontSansation);
  }

  TextStyle basicBlackTextStyle() {
    return TextStyle(
        letterSpacing: 0.5,
        height: 1.0,
        fontStyle: FontStyle.normal,
        fontSize: ScreenUtil().setSp(18.0),
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: AppFontFamily.fontSansation);
  }

  TextStyle titBlackTextStyle() {
    return TextStyle(
      letterSpacing: 0.0,
      height: 1.5,
      fontStyle: FontStyle.normal,
      fontSize: ScreenUtil().setSp(28.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  // Transaction TextStyles
  TextStyle listTitle() {
    return TextStyle(
      letterSpacing: 0.0,
      height: 1.5,
      fontStyle: FontStyle.normal,
      fontSize: ScreenUtil().setSp(18.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  TextStyle listSubTitle() {
    return TextStyle(
      letterSpacing: 0.0,
      height: 1.5,
      fontStyle: FontStyle.normal,
      fontSize: ScreenUtil().setSp(16.0),
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );
  }

  TextStyle listStatus({int status}) {
    // 1: sent 2:Received
    return TextStyle(
      letterSpacing: 0.0,
      height: 1.5,
      fontStyle: FontStyle.normal,
      fontSize: ScreenUtil().setSp(16.0),
      fontWeight: FontWeight.bold,
      color: status == 1 ? Colors.redAccent : Colors.green[400],
    );
  }

  TextStyle routingFontTextStyle() {
    return TextStyle(fontSize: ScreenUtil().setSp(18.0));
  }
}
