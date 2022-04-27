import 'package:shared_preferences/shared_preferences.dart';

clearData() async {
  //Beforeb Ending Session clear the data here
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return true;
}
