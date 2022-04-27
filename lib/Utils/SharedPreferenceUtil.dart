import 'package:Wallet/Utils/PrintUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  PrintUtil printUtil = PrintUtil();

  addSharedPref(String prefKey, String prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    printUtil.printMsg('$prefKey, $prefValue');
    prefs.setString(prefKey, prefValue);
  }

  addBoolSharedPref(String prefKey, bool prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    printUtil.printMsg('$prefKey, $prefValue');
    prefs.setBool(prefKey, prefValue);
  }

  Future<String> getSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefValue = prefs.getString(prefKey);
    return prefValue;
  }

  Future<bool> getBoolSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool prefValue = prefs.getBool(prefKey);
    return prefValue;
  }
}
