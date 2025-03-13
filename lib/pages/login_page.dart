import 'package:classplan_new/widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),
          Center(
            child: Image.asset(
              "assets/images/classplan_icon_main.png",
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "CLASSPLAN",
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 4.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          LoginWidget(),
        ],
      ),
    );
  }
}
