import 'dart:io';

import 'package:Wallet/Constants/text_styles.dart';
import 'package:Wallet/Screens/MyTransactions/bloc/mytransactionbloc_bloc.dart';
import 'package:Wallet/Screens/MyTransactions/widget/TransactionListView.dart';
import 'package:Wallet/Screens/MyTransactions/widget/pieChart.dart';
import 'package:Wallet/Screens/MyTransactions/widget/pieLegendOptions.dart';
import 'package:Wallet/Utils/helper_util.dart';
import 'package:Wallet/Utils/toast_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Wallet/Utils/loading_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shimmer/shimmer.dart';

class MyTransactionsMain extends StatefulWidget {
  MyTransactionsMain({Key key}) : super(key: key);
  @override
  _MyTransactionsMain createState() => _MyTransactionsMain();
}

class _MyTransactionsMain extends State<MyTransactionsMain> {
  MytransactionblocBloc myTransBloc = MytransactionblocBloc();

  bool isNetworkConnected = false;
  bool isLoading = false;
  var _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    myTransBloc.add(GetTransactionMainScreenEvent());
    onNetworkChange();
  }

  @override
  void dispose() {
    super.dispose();
    myTransBloc.close();
     _connectivitySubscription?.cancel();
  }

  /* On change in network wifi/mobile data */
  void onNetworkChange() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        if (result == ConnectivityResult.none) {
          isNetworkConnected = false;
        } else {
          myTransBloc.add(GetTransactionMainScreenEvent());
          isNetworkConnected = true;
        }
      });
    });
  }



  backHandle() {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you Sure You Want to Exit ?",style:FontTextStyle().titBlackTextStyle()),
            actions: <Widget>[
              TextButton(
                child: new Text("Yes",
                    style:FontTextStyle().basicBlackTextStyle()),
                onPressed: () {
                  exit(0);
                },
              ),
              TextButton(
                child: new Text("No",
                    style:FontTextStyle().basicBlackTextStyle()),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        },
      );
  }

  /* Show Progress Indication */
  void showProgress() {
    setState(() {
      isLoading = true;
    });
  }

  /* Clear Progress Indication */
  void dismissProgress() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MytransactionblocBloc, MytransactionblocState>(
        cubit: myTransBloc,
        builder: (context, state) {
          if (state is MytransactionblocLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const SizedBox(height: 80),
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (state is MytransactionScreenLoaded) {
            return !state.isInternetConnected ?
            HelperUtil.noInternetWidget(
                              context,
                              "NoInternet",
                              "Please Check Your Internet Connection",
                              "Retry",
                              "Please check your ineternet connection", retryAction: () {
                            HelperUtil.checkInternetConnection()
                                .then((internet) {
                              if (internet) {
                                myTransBloc.add(GetTransactionMainScreenEvent());
                              } else {
                                ToastUtil().showMsg(
                                  context,
                                  "Please check your ineternet connection",
                                );
                              }
                            });
                          })
            : ModalProgressHUD(
                progressIndicator: LoadingUtil.ballRotate(context),
                dismissible: false,
                inAsyncCall: isLoading,
                child: WillPopScope(
                    onWillPop: () {
                      backHandle();
                    },
                    child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setSp(28.0),
                                    top: ScreenUtil().setSp(2.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    drawPieChart(context),
                                    SizedBox(width: ScreenUtil().setSp(18.0)),
                                    drawPieLegendOptions()
                                  ],
                                ),
                              ),

                              //Transaction List
                              SizedBox(height: ScreenUtil().setSp(30.0)),
                              Container(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setSp(
                                          ScreenUtil().screenHeight * 0.45)),
                                  height: ScreenUtil().screenHeight * 0.90,
                                  width: ScreenUtil().screenWidth,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              ScreenUtil().setSp(30.0)),
                                          topRight: Radius.circular(
                                              ScreenUtil().setSp(30.0)))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setSp(28.0),
                                                top: ScreenUtil().setSp(20.0),
                                                bottom:
                                                    ScreenUtil().setSp(20.0)),
                                            child: Text("My Transactions",
                                                textAlign: TextAlign.start,
                                                style: FontTextStyle()
                                                    .titBlackTextStyle()),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: ScreenUtil().setSp(45),
                                            height: ScreenUtil().setSp(30),
                                            margin: EdgeInsets.only(
                                                right: ScreenUtil().setSp(28.0),
                                                top: ScreenUtil().setSp(20.0),
                                                bottom:
                                                    ScreenUtil().setSp(20.0)),
                                            // height: ScreenUtil().screenHeight * 0.4,
                                            // width: ScreenUtil().screenWidth * 0.02,
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue[900],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(ScreenUtil()
                                                        .setSp(18.0)))),
                                            child: Icon(
                                              Icons.tune_outlined,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      transactionListView(
                                          res: state
                                              .transactionResp.data.historyRes)
                                    ],
                                  ))
                            ]))));
          } else {
            return SizedBox();
          }
        });
  }
}
