import 'package:Wallet/Constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget customButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Container(
            width: ScreenUtil().screenWidth / 2 - ScreenUtil().setSp(35.0),
            height: ScreenUtil().setSp(50.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.blueAccent),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(ScreenUtil().setSp(8.0)),
                  textStyle: FontTextStyle().subTitTextStyle()),
              onPressed: null,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.north_east,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Pay',
                      style: FontTextStyle().basicTextStyle(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Spacer(),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Container(
            width: ScreenUtil().screenWidth / 2 - ScreenUtil().setSp(35.0),
            height: ScreenUtil().setSp(50.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(ScreenUtil().setSp(8.0)),
                  textStyle: FontTextStyle().subTitTextStyle()),
              onPressed: null,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.south_west,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Request',
                      style: FontTextStyle().basicBlackTextStyle(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
