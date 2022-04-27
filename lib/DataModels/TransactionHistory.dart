class TransactionHistory {
  String status;
  String result;
  Data data;

  TransactionHistory({this.status, this.result, this.data});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
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
  ChartMap chartMap;
  List<HistoryRes> historyRes;

  Data({this.chartMap, this.historyRes});

  Data.fromJson(Map<String, dynamic> json) {
    chartMap = json['chart_map'] != null
        ? new ChartMap.fromJson(json['chart_map'])
        : null;
    if (json['history_res'] != null) {
      historyRes = <HistoryRes>[];
      json['history_res'].forEach((v) {
        historyRes.add(new HistoryRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chartMap != null) {
      data['chart_map'] = this.chartMap.toJson();
    }
    if (this.historyRes != null) {
      data['history_res'] = this.historyRes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChartMap {
  int bitcoin;
  int ethereum;
  int ripley;
  int ruble;

  ChartMap({this.bitcoin, this.ethereum, this.ripley, this.ruble});

  ChartMap.fromJson(Map<String, dynamic> json) {
    bitcoin = json['Bitcoin'];
    ethereum = json['Ethereum'];
    ripley = json['Ripley'];
    ruble = json['Ruble'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Bitcoin'] = this.bitcoin;
    data['Ethereum'] = this.ethereum;
    data['Ripley'] = this.ripley;
    data['Ruble'] = this.ruble;
    return data;
  }
}

class HistoryRes {
  String title;
  String subTitle;
  String date;
  int status;
  int cardType;

  HistoryRes(
      {this.title, this.subTitle, this.date, this.status, this.cardType});

  HistoryRes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    date = json['date'];
    status = json['status'];
    cardType = json['cardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['date'] = this.date;
    data['status'] = this.status;
    data['cardType'] = this.cardType;
    return data;
  }
}
