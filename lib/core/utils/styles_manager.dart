import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.marcellus(
      fontWeight: fontWeight, color: color, fontSize: fontSize);
}

TextStyle _getTextGilroyStyle(
    double fontSize, FontWeight fontWeight, Color color, double height) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Gilroy-Medium',
      fontWeight: fontWeight,
      height: height);
}

// regular style

TextStyle getRegularStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getRegularGilroyStyle(
    {double fontSize = 12, required Color color, double height = 0.0}) {
  return _getTextGilroyStyle(
      fontSize, FontWeightManager.regular, color, height);
}

// medium style

TextStyle getMediumStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getMediumGilroyStyle(
    {double fontSize = 12, required Color color, double height = 0.0}) {
  return _getTextGilroyStyle(fontSize, FontWeightManager.medium, color, height);
}

// medium style

TextStyle getLightStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

TextStyle getLightGilroyStyle(
    {double fontSize = 12, required Color color, double height = 0.0}) {
  return _getTextGilroyStyle(fontSize, FontWeightManager.light, color, height);
}

// bold style

TextStyle getBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getBoldGilroyStyle(
    {double fontSize = 12, required Color color, double height = 0.0}) {
  return _getTextGilroyStyle(fontSize, FontWeightManager.bold, color, height);
}

// semiBold style

TextStyle getSemiBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

TextStyle getSemiBoldGilroyStyle(
    {double fontSize = 12, required Color color, double height = 0.0}) {
  return _getTextGilroyStyle(
      fontSize, FontWeightManager.semiBold, color, height);
}
