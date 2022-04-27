import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Wallet/Routers/Locator.dart';
import 'package:Wallet/Routers/NavigationService.dart';
import 'package:Wallet/Routers/Routing.dart';
import 'package:Wallet/Constants/appConstants.dart' as Constants;
import 'package:Wallet/Constants/routeConstants.dart' as RouteConstants;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 736),
      allowFontScaling: false,
      child: MaterialApp(
        title: Constants.appName,
        initialRoute: RouteConstants.routeDefault,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: Constants.buildType == 1 ? true : false,
      ),
    );
  }
}
