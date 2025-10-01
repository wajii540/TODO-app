import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      body: Column(
        children: [
          Row(children: [Image(image: AssetImage("assets/images/shape.png"))]),
          SizedBox(height: 10),
          Image(
            image: AssetImage("assets/images/undraw_mobile_ux_re_59hr 1.png"),
          ),
          SizedBox(height: 10),
          appText(
            text: "Get thingsdone with TODO",
            fontSize: 27,
            fontWeight: FontWeight.w700,
            textcolor: Colors.black,
          ),
          appText(
            text:
                "Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Sed\n posuere gravida purus id eu\n condimenum est diam quam.\nCondimentum blandit diam. ",
            fontSize: 19,
            fontWeight: FontWeight.w500,
            textcolor: Colors.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 335,
            height: 60,
            child: appButton(
              text: "Get Started",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textColor: Colors.black,
              onPressed: () => context.go("/registor"),
              borderRadius: BorderRadiusDirectional.circular(8),
              backgroundcolor: Color(0xFF62D2C3),
            ),
          ),
        ],
      ),
    );
  }
}
