import 'package:flutter/material.dart';
import 'package:todo_app_ui/widgets/app_text.dart';

Widget appButton({
  required String text,
  required VoidCallback onPressed,
  double? height,
  double? width,
  Color? backgroundcolor,
  Color? textColor,
  double? fontSize,
  FontWeight? fontWeight,
  BorderRadiusGeometry? borderRadius,
}) {
  return SizedBox(
    height: height ?? 50,
    width: width ?? double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundcolor ?? Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: appText(
        text: text,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.bold,
        textcolor: textColor ?? Colors.white,
      ),
    ),
  );
}
