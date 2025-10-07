import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_ui/Navigation/app_routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBodFDXNqg4cViqgBR5py60LbOFJHTx-KQ",
      appId: "1:917750164657:android:e27cca46bf85f0ca0f8690",
      messagingSenderId: "917750164657",
      projectId: "todo-app-c62ea",
    ),
  );
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
