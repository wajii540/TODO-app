import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

// Simple login screen wired to Firebase Auth

final TextEditingController _loginEmailController = TextEditingController();
final TextEditingController _loginPasswordController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;

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
            SizedBox(height: 25),
            appText(
              text: "Welcome back!",
              fontSize: 30,
              fontWeight: FontWeight.w600,
              textcolor: Colors.black,
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage(
                "assets/images/undraw_access_account_re_8spm 1.png",
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              height: 345,
              width: 330,
              child: Column(
                children: [
                  appTextField(
                    controller: _loginEmailController,
                    label: "Email",
                    hintText: "mary.elliot@mail.com",
                  ),
                  appTextField(
                    controller: _loginPasswordController,
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
                    onPressed: () async {
                      final email = _loginEmailController.text.trim();
                      final password = _loginPasswordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter email and password'),
                          ),
                        );
                        return;
                      }
                      try {
                        await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // navigate to dashboard on success
                        // ignore: use_build_context_synchronously
                        context.go('/dashboard');
                      } on FirebaseAuthException catch (e) {
                        print("FirebaseAuth error code: ${e.code}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? 'Login failed')),
                        );
                      }
                    },
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
                        onPressed: () => context.go("/registor"),
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
