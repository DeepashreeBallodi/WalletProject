import 'package:Wallet/Constants/ColorConstants.dart';
import 'package:Wallet/Constants/textStyles.dart';
import 'package:Wallet/Screens/MyTransactions/bloc/mytransactionbloc_bloc.dart';
import 'package:Wallet/Screens/MyWallet/bloc/mywalletbloc_bloc.dart';
import 'package:Wallet/Screens/MyWallet/widget/customButtons.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Wallet/Constants/appConstants.dart' as Constants;
import 'package:Wallet/Utils/LoadingUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shimmer/shimmer.dart';

class MyWalletMain extends StatefulWidget {
  MyWalletMain({Key key}) : super(key: key);
  @override
  _MyWalletMain createState() => _MyWalletMain();
}

class _MyWalletMain extends State<MyWalletMain> {
  MywalletblocBloc myWalletBloc = MywalletblocBloc();

  bool isNetworkConnected = false;
  bool isLoading = false;
  var _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    myWalletBloc.add(GetMyWalletMainScreenEvent());
  }

  @override
  void dispose() {
    super.dispose();
    myWalletBloc.close();
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
          isNetworkConnected = true;
        }
      });
    });
  }

  backHandle() {
    // Navigator.of(context).pop();
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
    return BlocBuilder<MywalletblocBloc, MywalletblocState>(
        cubit: myWalletBloc,
        builder: (context, state) {
          if (state is MywalletblocLoading) {
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
          } else if (state is MyWalletScreenLoaded) {
            return ModalProgressHUD(
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
                              top: ScreenUtil().setSp(20.0)),
                          child: Text("Availbale Balance",
                              textAlign: TextAlign.start,
                              style: FontTextStyle().subTitTextStyle()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setSp(28.0),
                              top: ScreenUtil().setSp(2.0),
                              bottom: ScreenUtil().setSp(28.0)),
                          child: Text(
                              "\$ ${state.walletResponse.data.accountBalance}",
                              textAlign: TextAlign.start,
                              style: FontTextStyle().amountTextStyle()),
                        ),

                        customButtons(),

                        //cards List
                        SizedBox(height: ScreenUtil().setSp(30.0)),
                        Container(
                            height: ScreenUtil().screenHeight * 0.90,
                            width: ScreenUtil().screenWidth,
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil()
                                    .setSp(ScreenUtil().screenHeight * 0.45)),
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
                                          bottom: ScreenUtil().setSp(20.0)),
                                      child: Text("My Cards",
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
                                          bottom: ScreenUtil().setSp(20.0)),
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue[900],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(18.0)))),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: state
                                      .walletResponse.data.walletRes.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setSp(28.0),
                                          right: ScreenUtil().setSp(28.0),
                                          top: ScreenUtil().setSp(8.0),
                                          bottom: ScreenUtil().setSp(8.0)),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(8.0)))),
                                      child: Image.network(
                                        state.walletResponse.data.walletRes[i]
                                            .cardImage,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.person);
                                        },
                                      ),
                                    );
                                  },
                                ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ));
          } else {
            return SizedBox();
          }
        });
  }
}
