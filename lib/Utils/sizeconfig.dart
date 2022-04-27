import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double screenWidthpx;
  static double screenHeightpx;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double headingSize;
  static double subHeadingSize;
  static double titleSize;
  static double subTitleSize;
  static double bntLargeSize;
  static double bntMediumSize;
  static double bntSmallSize;
  static double editLabelSize;
  static double editDetailsSize;
  static double formLabelSize;
  static double formTextSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidthpx =
        _mediaQueryData.size.width * _mediaQueryData.devicePixelRatio;
    screenHeightpx =
        _mediaQueryData.size.height * _mediaQueryData.devicePixelRatio;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    /* 
      Small Devices - Max-width - 600px
      Medium Devices - Max-width - 768px
      Large Devices - Max-width - 992px
    */
    if (screenWidthpx <= 600) {
      headingSize = 12;
      subHeadingSize = 10;
      titleSize = 8;
      subTitleSize = 6;
      bntLargeSize = 10;
      bntMediumSize = 8;
      bntSmallSize = 6;
      editLabelSize = 10;
      editDetailsSize = 13;
      formLabelSize = 10;
      formTextSize = 14;
    } else if (screenWidthpx > 600 && screenWidthpx <= 768) {
      headingSize = 14;
      subHeadingSize = 12;
      titleSize = 10;
      subTitleSize = 8;
      bntLargeSize = 14;
      bntMediumSize = 12;
      bntSmallSize = 10;
      editLabelSize = 12;
      editDetailsSize = 15;
      formLabelSize = 12;
      formTextSize = 16;
    } else {
      headingSize = 18;
      subHeadingSize = 16;
      titleSize = 14;
      subTitleSize = 12;
      bntLargeSize = 17;
      bntMediumSize = 15;
      bntSmallSize = 13;
      editLabelSize = 14;
      editDetailsSize = 17;
      formLabelSize = 14;
      formTextSize = 18;
    }
  }
}
