import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/screens/Login/loginbody.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 /*     appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xFF8B8B8B), fontSize:  18)
        ),
        title: Text("Sign In"),
      ),*/
      body: loginBody(),
    );
  }

}

