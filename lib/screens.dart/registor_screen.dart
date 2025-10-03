import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              fontSize: 30,
              fontWeight: FontWeight.w700,
              textcolor: Colors.black,
            ),
            SizedBox(height: 10),
            appText(
              text: "Let Help you in completing your tasks",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              textcolor: Colors.black87,
            ),
            SizedBox(height: 60),
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
                  SizedBox(height: 70),
                  appButton(
                    text: "Registor",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    onPressed: () => context.go("/loginPage"),
                    backgroundcolor: Appcolors.primarycolor,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appText(text: "Already have an account?", fontSize: 15),
                      TextButton(
                        onPressed: () => context.go("/loginPage"),
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
