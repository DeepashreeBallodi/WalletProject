import 'package:Wallet/Utils/LoadingUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Wallet/Constants/routeConstants.dart' as RouteConstants;

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white, // Android
          statusBarBrightness: Brightness.light // iOS
          ),
    );

    checkSessionAndNavigate(context).then((res) async {
      if (res == 1) {
        //Navigate to Dashboard
        Navigator.of(context)
            .pushReplacementNamed(RouteConstants.routeToBottomNavigationBar);
      } else {
        //Navigate to Login Screen
      }
    });
  }

  Future<int> checkSessionAndNavigate(context) async {
    //Check Stored Session here and return value
    /* 
    if (isAlreadyLogin == "1") {
      return 1;
    } else {
      return 2;
    }*/
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: LoadingUtil.pacman(context),
      child: Scaffold(
        body: Card(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
