import 'package:flutter/material.dart';

import '../../../../app.dart';
import '../LoginPage/login_page.dart';

class RegisterPage extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final signInButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color.fromARGB(255, 44, 44, 124),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (context) => MainApp(),
            ),
          );
        },
        child: Text('Sign In',
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final goToLoginPageText = GestureDetector(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(builder: (context) => LoginPage()),
        );
      },
      child: Text(
        'Login',
        style: TextStyle(
          color: const Color.fromARGB(255, 200, 200, 200),
          decoration: TextDecoration.underline,
        ),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 70, 70, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 900,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white70,
                  Colors.white54,
                  Colors.white30,
                  Colors.white10,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        'assets/Emotify_logo_transparent.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    signInButon,
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Do you have an account? '),
                        goToLoginPageText,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
