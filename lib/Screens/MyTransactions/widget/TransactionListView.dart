import 'package:Wallet/Constants/images.dart';
import 'package:Wallet/Constants/textStyles.dart';
import 'package:Wallet/DataModels/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget transactionListView({List<HistoryRes> res}) {
  final colorList = <Color>[
    Color(0xffebeb42),
    Color(0xffaf85e6),
    Color(0xffed8eea),
    Color(0xff9dc8eb)
  ];
  final cardIcons = <String>[
    ImagePaths.bitcoin,
    ImagePaths.ethereum,
    ImagePaths.ripley,
    ImagePaths.ruble
  ];

  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: res.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: CircleAvatar(
            child: Container(
              height: ScreenUtil().setSp(15.0),
              width: ScreenUtil().setSp(15.0),
              child: Image.asset(cardIcons[res[i].cardType - 1]),
            ),
            backgroundColor: colorList[res[i].cardType - 1],
          ),
          title: Text(res[i].title, style: FontTextStyle().listTitle()),
          subtitle:
              Text(res[i].subTitle, style: FontTextStyle().listSubTitle()),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(res[i].date, style: FontTextStyle().listSubTitle()),
              Text(res[i].status == 1 ? "Sent" : "Received",
                  style: FontTextStyle().listStatus(status: res[i].status))
            ],
          ),
        );
      },
    ),
  );
}
