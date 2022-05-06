import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingUtil {
  static Widget ballPulse(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black26,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  static Widget ballGridBeat(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballGridBeat,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  static Widget pacman(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.pacman,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  static Widget ballRotate(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotate,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  static Widget ballRotateWithText(BuildContext context, String displayText) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotate,
                color: Colors.blue,
              ),
            ),
            Container(
              child: Text(
                displayText,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
