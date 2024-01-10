import 'dart:async';

import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/LoginView.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, LoginView.route);
    });
    return Scaffold(
      backgroundColor: colors.mainColor,
      body: const Center(
          child: Text(
        'F i x e r',
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
