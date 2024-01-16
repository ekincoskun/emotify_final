import 'package:flutter/material.dart';
import 'Client/Presentation/UIManager/LoginPage/login_page.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emotify',
      home: MainApp(),
    ),
  );
}
