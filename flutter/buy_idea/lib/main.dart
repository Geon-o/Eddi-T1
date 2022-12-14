import 'package:buy_idea/pages/account/select_sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
    textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: Color(0xFF2F4F4F),
    primary: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    minimumSize: Size(140, 130)
    )
    ),
    ),
    title: 'signUp',
    initialRoute: "/selectSignUp",
    routes: {
    "/selectSignUp": (context) => SelectSignUpPage()
    },
    );
  }
}