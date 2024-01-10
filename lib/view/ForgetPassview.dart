import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/LoginView.dart';
import 'package:fixer_app/view/widgets/TextForm.dart';
import 'package:flutter/material.dart';

class ForgetPassview extends StatefulWidget {
  static const String route = 'ForgetPassview';
  const ForgetPassview({super.key});

  @override
  State<ForgetPassview> createState() => _ForgetPassview();
}

class _ForgetPassview extends State<ForgetPassview> {
  final auth = FirebaseAuth.instance;
  final TextEditingController emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await auth.sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('password reset link is sent to your email!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry'),
              content: Text(
                'the email is wrong!',
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Forgot your password ',
                  style: TextStyle(
                    color: colors.mainColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Enter your email and we will send you a reset password link ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextForm(
                controller: emailcontroller,
                Text: 'Enter your Email',
                obsecure: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                  onTap: () {
                    passwordReset();
                    Navigator.pushNamed(context, LoginView.route);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      color: colors.mainColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
                      'Reset Password',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'return to ',
              style: TextStyle(fontSize: 15),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, LoginView.route);
              },
              child: Text(
                ' Log in',
                style: TextStyle(color: colors.mainColor, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
