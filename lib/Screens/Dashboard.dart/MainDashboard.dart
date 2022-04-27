import 'package:Wallet/Constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:Wallet/Utils/LoadingUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MainDashboard extends StatefulWidget {
  MainDashboard({Key key}) : super(key: key);
  @override
  _MainDashboard createState() => _MainDashboard();
}

class _MainDashboard extends State<MainDashboard> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  backHandle() {
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: LoadingUtil.ballRotate(context),
        dismissible: false,
        inAsyncCall: isLoading,
        child: WillPopScope(
            onWillPop: () {
              backHandle();
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setSp(30.0)),
                  Container(
                      height: ScreenUtil().screenHeight * 0.6731,
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(ScreenUtil().setSp(30.0)),
                              topRight:
                                  Radius.circular(ScreenUtil().setSp(30.0)))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setSp(28.0),
                                    top: ScreenUtil().setSp(20.0),
                                    bottom: ScreenUtil().setSp(20.0)),
                                child: Text("Dashboard",
                                    textAlign: TextAlign.start,
                                    style: FontTextStyle().titBlackTextStyle()),
                              )
                            ],
                          ),
                        ],
                      ))
                ])));
  }
}
