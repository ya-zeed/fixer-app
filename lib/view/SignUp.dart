import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/Home.dart';
import 'package:fixer_app/view/LoginView.dart';
import 'package:fixer_app/view/widgets/TextForm.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  static const String route = 'SignUp';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final auth = FirebaseAuth.instance;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController Passwordcontroller = TextEditingController();
  final TextEditingController ConfirmPaawordcontroller =
      TextEditingController();
  late String email;
  late String password;

  bool doPasswordsMatch() {
    String password = Passwordcontroller.text;
    String confirmPassword = ConfirmPaawordcontroller.text;
    return password == confirmPassword;
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
                          'Hi! ,Sign up to continue',
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
                        SizedBox(
                          height: 15,
                        ),
                        TextForm(
                            controller: ConfirmPaawordcontroller,
                            Text: 'confirm your password',
                            textInputType: TextInputType.text,
                            obsecure: true),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            onTap: () async {
                              if (doPasswordsMatch()) {
                                try {
                                  String ID = randomAlphaNumeric(6);

                                  var user =
                                      await auth.createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  await user.user!.updateDisplayName(ID);

                                  Navigator.pushNamed(context, Home.route);
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Sorry'),
                                        content: Text(
                                          'Password do not match',
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
                                'Sign up',
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
            Text(
              'you have an account?',
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, LoginView.route);
              },
              child: Text(
                ' Log in',
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
