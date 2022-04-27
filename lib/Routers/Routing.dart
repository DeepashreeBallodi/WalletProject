import 'package:Wallet/Screens/BottomNavigationBar/MainBottonNavigationBar.dart';
import 'package:Wallet/Screens/BottomNavigationBar/Widget/NavBarIcons.dart';
import 'package:Wallet/Screens/MyTransactions/MyTransactionsMain.dart';
import 'package:Wallet/Screens/MyWallet/MyWalletMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:Wallet/Constants/appConstants.dart' as Constants;
import 'package:Wallet/Constants/routeConstants.dart' as RouteConstants;
import 'package:Wallet/Constants/textStyles.dart';
import 'package:Wallet/Screens/LaunchScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteConstants.routeDefault:
        Future.delayed(Duration(seconds: 3), () {
          FlutterSplashScreen.hide();
        });
        return MaterialPageRoute(
            builder: (_) => LaunchScreen(),
            settings: RouteSettings(name: settings.name));
        break;

      case RouteConstants.routeToBottomNavigationBar:
        Map<String, dynamic> data;
        data = args;
        return MaterialPageRoute(
            builder: (_) => MainBottonNavigationBar(),
            settings: RouteSettings(name: settings.name));
        break;

      case RouteConstants.routeToMyTrasnsactions:
        Map<String, dynamic> data;
        data = args;
        return MaterialPageRoute(
            builder: (_) => MyTransactionsMain(),
            settings: RouteSettings(name: settings.name));
        break;

      case RouteConstants.routeToMyWallet:
        Map<String, dynamic> data;
        data = args;
        return MaterialPageRoute(
            builder: (_) => MyWalletMain(),
            settings: RouteSettings(name: settings.name));
        break;

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(pageName) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline),
              Text(
                RouteConstants.errPageText + pageName.toString(),
                style: FontTextStyle().titTextStyle(),
              )
            ],
          ),
        ),
      );
    });
  }
}
