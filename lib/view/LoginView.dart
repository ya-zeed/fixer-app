import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/ForgetPassview.dart';
import 'package:fixer_app/view/Home.dart';
import 'package:fixer_app/view/SignUp.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  static const String route = 'LoginView';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _Loginview();
}

class _Loginview extends State<LoginView> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController Passwordcontroller = TextEditingController();

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
                      height: 150,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'F i x e r ',
                        style: TextStyle(
                          color: colors.mainColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Column(
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: colors.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'sign to continue',
                          style: TextStyle(
                            color: colors.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 2,
                              left: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(0),
                                    hintStyle: const TextStyle(
                                      height: 1,
                                    )))),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 2,
                              left: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                controller: Passwordcontroller,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(0),
                                    hintStyle: const TextStyle(
                                      height: 1,
                                    )))),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ForgetPassview.route);
                                  },
                                  child: Text(
                                    'Forgot your password?',
                                    style: TextStyle(color: Colors.grey[700]),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            onTap: () async {
                              try {
                                var user =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushNamed(context, Home.route);
                                }
                              } on FirebaseAuthException catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Sorry'),
                                        content: Text(
                                          'Email or pasword is wrong',
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
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ))),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dont have an account?',
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SignUp.route);
              },
              child: Text(
                ' sign up',
                style: TextStyle(
                  color: colors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
