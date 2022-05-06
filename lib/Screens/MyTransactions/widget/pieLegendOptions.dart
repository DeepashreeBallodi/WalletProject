import 'package:Wallet/Constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget drawPieLegendOptions() {
  List<String> dataMap = ["Bitcoin", "Ethereum", "Ripley", "Ruble"];

  final colorList = <Color>[
    Color(0xffebeb42),
    Color(0xffaf85e6),
    Color(0xffed8eea),
    Color(0xff9dc8eb)
  ];

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(dataMap.length, (index) {
        return optionRow(colorList[index], dataMap[index]);
      }));
}

Widget optionRow(Color color, String textLbl) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: color, width: ScreenUtil().setSp(4.0)),
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 4,
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          textLbl,
          style: FontTextStyle().subTitTextStyle(),
        ),
        SizedBox(width: 20.0),
      ],
    ),
  );
}
