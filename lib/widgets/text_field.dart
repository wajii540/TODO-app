import 'package:flutter/material.dart';
import 'package:todo_app_ui/widgets/app_text.dart';

Widget appTextField({
  required String label,
  required String hintText,
  bool isPassword = false,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: appText(
          text: label,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          textcolor: Colors.black,
        ),
      ),
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),

          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          //   // borderSide: BorderSide(color: Colors.black),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          //   // borderSide: BorderSide(color: Colors.black),
          // ),
        ),
      ),
    ],
  );
}
