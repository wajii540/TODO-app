import 'package:flutter/material.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

class RegistorScreen extends StatelessWidget {
  const RegistorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [Image(image: AssetImage("assets/images/shape.png"))],
            ),
            SizedBox(height: 10),
            appText(
              text: "Welcome Onboard!",
              fontSize: 27,
              fontWeight: FontWeight.w700,
              textcolor: Colors.black,
            ),
            SizedBox(height: 10),
            appText(
              text: "Let Help you in completing your tasks",
              fontSize: 22,
              fontWeight: FontWeight.w500,
              textcolor: Colors.black87,
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 600,
              width: 330,
              child: Column(
                children: [
                  appTextField(label: "Full name", hintText: "Mary Elliot"),
                  appTextField(
                    label: "Email",
                    hintText: "mary.elliot@mail.com",
                  ),
                  appTextField(
                    label: "Password",
                    hintText: "************",
                    isPassword: true,
                  ),
                  appTextField(
                    label: "Confirm Password",
                    hintText: "************",
                    isPassword: true,
                  ),
                  SizedBox(height: 15),
                  appButton(
                    text: "Registor",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    onPressed: () {},
                    backgroundcolor: Appcolors.primarycolor,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appText(text: "Already have an account?", fontSize: 15),
                      TextButton(
                        onPressed: () {},
                        child: appText(
                          text: "Sign in",
                          textcolor: Appcolors.primarycolor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
