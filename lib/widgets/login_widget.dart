import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import '../pages/main_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String login_data = "";
  String password_data = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Text(
          "Logowanie",
          style: onSurfaceTextStyle(context).copyWith(fontSize: 17),
        ),
        SizedBox(height: 50),
        SizedBox(
          width: 300,
          child: TextField(
            onChanged: (value) => {login_data = value},
            decoration: InputDecoration(hintText: "Login"),
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            onChanged: (value) => {password_data = value},
            decoration: InputDecoration(hintText: "Hasło"),
          ),
        ),
        SizedBox(height: 50),
        OutlinedButton(
          onPressed: () => checkLogin(password_data, login_data, context),
          child: Text("Zaloguj"),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainPage();
                  },
                ),
              ),
          child: Text("Skip login"),
        ),
      ],
    );
  }
}

bool checkLogin(String psw, String login, BuildContext context) {
  if (psw == "ADMIN" && login == "ADMIN") {
    showDialog(
      //LOGIN PROCESS SUCCESS
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logowanie"),
          content: Text("Logowanie się powiodło!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Rozumiem"),
            ),
          ],
        );
      },
    );
    return true;
  } else {
    showDialog(
      //LOGIN PROCESS FAIL
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logowanie"),
          content: Text("Logowanie się nie powiodło!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Rozumiem"),
            ),
          ],
        );
      },
    );
    return false;
  }
}
