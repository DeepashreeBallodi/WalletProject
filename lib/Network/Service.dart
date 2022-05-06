

import 'package:Wallet/DataModels/TransactionHistory.dart';
import 'package:Wallet/DataModels/WalletModel.dart';
import 'package:Wallet/Network/Network.dart';
import 'package:Wallet/Utils/print_util.dart';

class Service {
  /* Declarations */
  Network _network = new Network();
  PrintUtil printClass = PrintUtil();
  Map<String, String> paramsKeyVal;
  static int apiHitTimeout = 30;

  /* Development */
  static final basicUrl = "";
  static final tc = "";

  /* Pre Production */
  // static final basicUrl = "";
  // static final tc = "";

  /* Production */
  // static final basicUrl = "";
  // static final tc = "";

  /* Url Declarations Started*/
  static final getDashboardUrl = '$basicUrl/Dashboar';

  /* To Test Dummy API Response Used */
  var walletResponse = {
    "status": "Success",
    "result": "Wallet Response Loaded successfully!!",
    "data": {
      "account_balance": "18 420.80",
      "wallet_res": [
        {
          "card_name": "Master Card",
          "card_image":
              "https://www.bobfinancial.com/images/Prime-CardNew-PNG.png"
        },
        {
          "card_name": "Master Card",
          "card_image":
              "https://i.pinimg.com/originals/64/be/b3/64beb3f2ff210bec23f22355f0f9f711.png"
        },
        {
          "card_name": "Visa Card",
          "card_image":
              "https://hips.hearstapps.com/pop.h-cdn.co/assets/17/16/980x619/gallery-1492705719-card2.jpg?resize=480:*"
        }
      ]
    }
  };

  var transactionResponse = {
    "status": "Success",
    "result": "Transaction Response Loaded successfully!!",
    "data": {
      "chart_map": {"Bitcoin": 3, "Ethereum": 8, "Ripley": 1, "Ruble": 2},
      "history_res": [
        {
          "title": "Bitcoin",
          "subTitle": "-0.30533 BTC",
          "date": "08 Oct 2022",
          "status": 1,
          "cardType": 1
        },
        {
          "title": "Ethereum",
          "subTitle": "+4.2630 ETH",
          "date": "07 Sep 2022",
          "status": 2,
          "cardType": 2
        },
        {
          "title": "Bitcoin",
          "subTitle": "+0.26322 BTC",
          "date": "13 Jul 2022",
          "status": 2,
          "cardType": 1
        },
        {
          "title": "Ripley",
          "subTitle": "-1.3430 RIP",
          "date": "15 May 2022",
          "status": 1,
          "cardType": 3
        },
        {
          "title": "Ruble",
          "subTitle": "-8.3430 RUB",
          "date": "17 May 2022",
          "status": 1,
          "cardType": 4
        }
      ]
    }
  };

/* Get Wallet data */
  WalletData getWalletData() {
    // return _network
    //     .post(apiHitTimeout, getDashboardUrl, body: paramsKeyVal)
    //     .then((dynamic res) {
    //   return res
    // });
    return WalletData.fromJson(walletResponse);
  }

  /* Get Transaction data */
  TransactionHistory getTransactionData() {
    // return _network
    //     .post(apiHitTimeout, getDashboardUrl, body: paramsKeyVal)
    //     .then((dynamic res) {
    //   return res;
    // });
    return TransactionHistory.fromJson(transactionResponse);
  }
}
