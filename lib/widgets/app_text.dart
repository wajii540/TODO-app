import 'package:flutter/material.dart';

Widget appText({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? textcolor,
  dynamic colorsPalatte,
  fontfamily,
  TextAlign? textAlign,
  TextDecoration? decoration,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight,
      color: textcolor,
      decoration: decoration,
    ),
  );
}
