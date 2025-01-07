import 'package:flutter/material.dart';

TextStyle customTextStyle({
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w400,
  Color color = Colors.black,
  String fontFamily = 'Work Sans', 
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: fontFamily,
  );
}
