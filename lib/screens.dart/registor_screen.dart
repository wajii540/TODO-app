import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

final TextEditingController _regNameController = TextEditingController();
final TextEditingController _regEmailController = TextEditingController();
final TextEditingController _regPasswordController = TextEditingController();
final TextEditingController _regConfirmPasswordController =
    TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                  appTextField(
                    controller: _regNameController,
                    label: "Full name",
                    hintText: "Mary Elliot",
                  ),
                  appTextField(
                    controller: _regEmailController,
                    label: "Email",
                    hintText: "mary.elliot@mail.com",
                  ),
                  appTextField(
                    controller: _regPasswordController,
                    label: "Password",
                    hintText: "************",
                    isPassword: true,
                  ),
                  appTextField(
                    controller: _regConfirmPasswordController,
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
                    onPressed: () async {
                      final name = _regNameController.text.trim();
                      final email = _regEmailController.text.trim();
                      final password = _regPasswordController.text.trim();
                      final confirm = _regConfirmPasswordController.text.trim();
                      if (name.isEmpty || email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all required fields'),
                          ),
                        );
                        return;
                      }
                      if (password != confirm) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                        return;
                      }

                      // show a loading dialog to prevent double taps
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                      );

                      try {
                        final cred = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        final uid = cred.user?.uid;
                        if (uid != null) {
                          await _firestore.collection('users').doc(uid).set({
                            'name': name,
                            'email': email,
                            'createdAt': FieldValue.serverTimestamp(),
                          });
                        }
                        // closing loading dialog
                        Navigator.of(context, rootNavigator: true).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration successful'),
                          ),
                        );
                        context.go('/loginPage');
                      } on FirebaseAuthException catch (e) {
                        Navigator.of(context, rootNavigator: true).pop();
                        // print to console for debugging
                        // ignore: avoid_print
                        print(
                          'FirebaseAuthException during register: ${e.code} ${e.message}',
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message ?? 'Registration failed'),
                          ),
                        );
                      } catch (e, s) {
                        Navigator.of(context, rootNavigator: true).pop();
                        // ignore: avoid_print
                        print('Unknown error during registration: $e');
                        // ignore: avoid_print
                        print(s);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Registration failed: ${e.toString()}',
                            ),
                          ),
                        );
                      }
                    },
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
