import 'package:Wallet/Constants/appConstants.dart' as Constants;

class PrintUtil {
  /* Common Print Method */
  void printMsg(msg) {
    if (Constants.buildType != 3) {
      printWrapped(msg.toString());
    }
  }

  /* To Print Larger Response */
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
