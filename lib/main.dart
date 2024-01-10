import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fixer_app/view/AssignTask.dart';
import 'package:fixer_app/view/ForgetPassview.dart';
import 'package:fixer_app/view/Home.dart';
import 'package:fixer_app/view/LoginView.dart';
import 'package:fixer_app/view/Profile.dart';
import 'package:fixer_app/view/SignUp.dart';
import 'package:fixer_app/view/SplashView.dart';
import 'package:fixer_app/view/YourTasks.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCKCuultdptPLDE_bbHPi1tVLDt0ZWlWU4",
            appId: "1:399835797326:android:2e31454f81de9a5ac7b01f",
            messagingSenderId: "399835797326",
            projectId: "gp2fixer",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const fixer());
}

class fixer extends StatelessWidget {
  const fixer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fixer app',
        theme: ThemeData(primarySwatch: Colors.grey),
        home: const SplashView(),
        routes: {
          SignUp.route: (context) => SignUp(),
          LoginView.route: (context) => LoginView(),
          Home.route: (context) => Home(),
          ForgetPassview.route: (context) => ForgetPassview(),
          Profile.route: (context) => Profile(),
          YourTask.route: (context) => YourTask(),
          AssignTask.route: (context) => AssignTask(),
        });
  }
}
