import 'package:Wallet/Constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

Widget drawPieChart(
  BuildContext context,
) {
  Map<String, double> dataMap = {
    "Bitcoin": 3,
    "Ethereum": 8,
    "Ripley": 1,
    "Ruble": 2,
  };

  final colorList = <Color>[
    Color(0xffebeb42),
    Color(0xffaf85e6),
    Color(0xffed8eea),
    Color(0xff9dc8eb)
  ];

  return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 2.8,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 15,
      centerText: "Available Coins",
      centerTextStyle: FontTextStyle().subTitTextStyle(),
      legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: false,
          legendShape: BoxShape.circle,
          legendTextStyle: FontTextStyle().subTitTextStyle()),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ));
}
