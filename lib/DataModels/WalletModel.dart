class WalletData {
  String status;
  String result;
  Data data;

  WalletData({this.status, this.result, this.data});

  WalletData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String accountBalance;
  List<WalletRes> walletRes;

  Data({this.accountBalance, this.walletRes});

  Data.fromJson(Map<String, dynamic> json) {
    accountBalance = json['account_balance'];
    if (json['wallet_res'] != null) {
      walletRes = <WalletRes>[];
      json['wallet_res'].forEach((v) {
        walletRes.add(new WalletRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_balance'] = this.accountBalance;
    if (this.walletRes != null) {
      data['wallet_res'] = this.walletRes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletRes {
  String cardName;
  String cardImage;

  WalletRes({this.cardName, this.cardImage});

  WalletRes.fromJson(Map<String, dynamic> json) {
    cardName = json['card_name'];
    cardImage = json['card_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_name'] = this.cardName;
    data['card_image'] = this.cardImage;
    return data;
  }
}
