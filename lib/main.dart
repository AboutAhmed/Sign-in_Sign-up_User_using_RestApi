import 'package:flutter/material.dart';
import 'package:sign_in_and_sign_up/Log_in.dart';
import 'package:sign_in_and_sign_up/Sign_up.dart';
import 'package:sign_in_and_sign_up/Upload_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:  uploadimagescreen());
  }
}
