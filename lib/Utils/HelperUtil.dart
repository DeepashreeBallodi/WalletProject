import 'dart:ui';
import 'package:Wallet/Constants/ColorConstants.dart';
import 'package:Wallet/Constants/images.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:Wallet/Constants/appConstants.dart' as Constants;

class HelperUtil {
  static String getNameTest() {
    return "Hello World";
  }

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static displaySnackBar(BuildContext context, String text) {
    Scaffold.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 6),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Widget noInternetWidget(BuildContext context, String noInternetMsg,
      noInteenetDesc, retryBtn, noInternetToast,
      {retryAction}) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.0,
          ),
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePaths.noInternet),
                  fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              '$noInternetMsg',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              noInteenetDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                   color: AppColors.blue,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 50,
            width: 150,
            child: RaisedButton(
              child: Text(
                '$retryBtn',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: retryAction,
              color: AppColors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
            ),
          ),
        ],
      ),
    );
  }

  static bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
