import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

   void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    print('$screenWidth');
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
/// هاي الدالة بترجعلي الطول او الارتفاع المناسب للصورة على الشاشات المختلفة
double getProportionateScreenHeight(double inputHeight) {
  /// هان خزنت قيمه الارتفاع من كلاس SizeConfig وخزنتها في متغير
  double screenHeight = SizeConfig.screenHeight;
  /// 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
/// هاي الدالة بترجعلي العرض المناسب حسب حجم الشاشة
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
