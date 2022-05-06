import 'package:Wallet/Constants/color_constants.dart';
import 'package:Wallet/Constants/images.dart';
import 'package:Wallet/Constants/text_styles.dart';
import 'package:Wallet/Screens/BottomNavigationBar/Widget/NavBarIcons.dart';
import 'package:Wallet/Screens/Dashboard.dart/MainDashboard.dart';
import 'package:Wallet/Screens/MyTransactions/MyTransactionsMain.dart';
import 'package:Wallet/Screens/MyWallet/MyWalletMain.dart';
import 'package:Wallet/Screens/Profile.dart/MainProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainBottonNavigationBar extends StatefulWidget {
  const MainBottonNavigationBar({Key key}) : super(key: key);

  @override
  _MainBottonNavigationBar createState() => _MainBottonNavigationBar();
}

class _MainBottonNavigationBar extends State<MainBottonNavigationBar> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  static List<Widget> _pages = navBarIcons();

  /* On Tap Function */
  void _onItemTapped(int index) {
    selectedIndex.value = index;
  }

  /* App Bar Titles*/
  static List<String> _appBarTitles = [
    "DASHBOARD",
    "MY WALLET",
    "MY TRANSACTIONS",
    "MY PROFILE"
  ];

  /* Get New Page */
  loadPage(int index) {
    if (index == 0) {
      return MainDashboard();
    } else if (index == 1) {
      return MyWalletMain();
    } else if (index == 2) {
      return MyTransactionsMain();
    } else if (index == 3) {
      return MainProfile();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int counterValue, Widget child) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.blue,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(ScreenUtil().setSp(
                        ScreenUtil().screenHeight *
                            0.18)), // here the desired height
                    child: AppBar(
                      title: Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setSp(30.0)),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Container(
                                  height: ScreenUtil().setSp(40),
                                  width: ScreenUtil().setSp(35),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBwgu1A5zgPSvfE83nurkuzNEoXs9DMNr8Ww&usqp=CAU',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.person);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(_appBarTitles[selectedIndex.value],
                                style: FontTextStyle().titTextStyle()),
                            Spacer(),
                            new Stack(
                              children: <Widget>[
                                new Icon(Icons.notifications_outlined),
                                new Positioned(
                                  right: 0,
                                  child: new Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: new Text(
                                      '2',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.1),
                                  BlendMode.dstATop),
                              image: AssetImage(ImagePaths.mainAppBar)),
                        ),
                      ),
                      backgroundColor: AppColors.blue,
                      elevation: 0.0,
                    )),
                body: loadPage(selectedIndex.value),
                bottomNavigationBar: Container(
                  color: Colors.white,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setSp(1.0),
                          right: ScreenUtil().setSp(1.0)),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        backgroundBlendMode: BlendMode.clear,
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setSp(30.0))),
                      ),
                      height: ScreenUtil().screenHeight * 0.085,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setSp(30.0))),
                        child: BottomNavigationBar(
                          backgroundColor: AppColors.blue,
                          type: BottomNavigationBarType.fixed,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.dashboard,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.white,
                                ),
                              ),
                              activeIcon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.dashboard,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.blueAccent[100],
                                ),
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.white,
                                ),
                              ),
                              activeIcon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.blueAccent[100],
                                ),
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.history,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.white,
                                ),
                              ),
                              activeIcon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.history,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.blueAccent[100],
                                ),
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.perm_identity_outlined,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.white,
                                ),
                              ),
                              activeIcon: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.perm_identity_outlined,
                                  size: ScreenUtil().setSp(28),
                                  color: Colors.blueAccent[100],
                                ),
                              ),
                              label: '',
                            )
                          ],
                          currentIndex: selectedIndex.value,
                          onTap: _onItemTapped,
                        ),
                      )),
                )),
          );
        });
  }
}
