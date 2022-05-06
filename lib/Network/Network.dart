import 'dart:convert';
import 'package:Wallet/Routers/locator.dart';
import 'package:Wallet/Routers/NavigationService.dart';
import 'package:Wallet/Utils/print_util.dart';
import 'package:http/http.dart' as http;

class Network {
  PrintUtil printUtil = PrintUtil();

  /* Singleton Class */
  static Network _instance = new Network.internal();
  Network.internal();
  factory Network() => _instance;

  /* Json Decoder */
  final JsonDecoder _decoder = new JsonDecoder();

  final NavigationService _navigationService = locator<NavigationService>();

  /* Get Http Call */
  Future<dynamic> get(int apiTimeout, String url) {
    return http.get(url).then((http.Response response) {
      final Map<String, dynamic> res = _decoder.convert(response.body);
      final int statusCode = response.statusCode;
      printUtil.printMsg("<<<  Method GET  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>> ");
      printUtil.printMsg(response.body);
      printUtil.printMsg("<<< API Call End >>>");
      if (res.containsKey('logout')) {
        if (statusCode < 200 ||
            statusCode > 400 ||
            res == null ||
            res['logout']) {
          //Failure response
        }
      } else {
        if (statusCode < 200 || statusCode > 400 || res == null) {}
      }
      return res;
    }).catchError((onError) {
      // if (Constants.buildType == 3) {
      //   final slack =
      //       SlackNotifier('TBTD5BKT3/B02BV9C0WRJ/W3Oi7ZBAKdAB9f0mOoLi9AjM');
      //   slack.send('API: $url || Method: GET || OnError: $onError',
      //       channel: 'flutter_ffa_errors');
      //   // }
      // }).timeout(Duration(seconds: apiTimeout), onTimeout: () {
      //   // if (Constants.buildType == 3) {
      //   final slack =
      //       SlackNotifier('TBTD5BKT3/B02BV9C0WRJ/W3Oi7ZBAKdAB9f0mOoLi9AjM');
      //   slack.send('Timout API: $url || Method: GET',
      //       channel: 'flutter_ffa_errors');
      // }
      return null;
    });
  }

  /* Post Http Call */
  Future<dynamic> post(int apiTimeout, String url,
      {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final Map<String, dynamic> res = _decoder.convert(response.body);
      final int statusCode = response.statusCode;
      printUtil.printMsg("<<<  Method POST  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(body.toString());
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(response.body);
      printUtil.printMsg("<<< API Call End >>>");
      if (res.containsKey('logout')) {
        if (statusCode < 200 ||
            statusCode > 400 ||
            res == null ||
            res['logout']) {
          //Failure response
        }
      } else {
        if (statusCode < 200 || statusCode > 400 || res == null) {}
      }
      return res;
    }).catchError((onError) {
      return null;
    });
  }

  /* Auth Key Post Http Call */
  Future<dynamic> authHeadpost(int apiTimeout, String url,
      {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final res = response.bodyBytes;
      final int statusCode = response.statusCode;
      printUtil.printMsg("<<<  Method POST  >>>");
      printUtil.printMsg("<<< API Call Start to $url >>");
      printUtil.printMsg("<<< Request >>>");
      printUtil.printMsg(headers.toString());
      printUtil.printMsg("<<< API Status Code $statusCode >>>");
      printUtil.printMsg("<<< Response >>>");
      printUtil.printMsg(res);
      printUtil.printMsg("<<< API Call End >>>");
      return res;
    }).catchError((onError) {
      return null;
    });
  }
}
