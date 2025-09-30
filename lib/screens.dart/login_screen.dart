import 'package:flutter/material.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.c0xFFE6E6E6,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [Image(image: AssetImage("assets/images/shape.png"))],
            ),
            SizedBox(height: 10),
            appText(
              text: "Welcome back!",
              fontSize: 25,
              fontWeight: FontWeight.w600,
              textcolor: Colors.black,
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage(
                "assets/images/undraw_access_account_re_8spm 1.png",
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 500,
              width: 330,
              child: Column(
                children: [
                  appTextField(
                    label: "Email",
                    hintText: "mary.elliot@mail.com",
                  ),
                  appTextField(
                    label: "Password",
                    hintText: "************",
                    isPassword: true,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: appText(
                          text: "Forget Password",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          textcolor: Appcolors.c0xFF62D2C3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  appButton(
                    text: "Login",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    onPressed: () {},
                    backgroundcolor: Appcolors.primarycolor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appText(
                        text: "Don't have an account?",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        textcolor: Colors.black,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: appText(
                          text: "Sign Up",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          textcolor: Appcolors.c0xFF62D2C3,
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
