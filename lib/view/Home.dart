import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/AssignTask.dart';
import 'package:fixer_app/view/LoginView.dart';
import 'package:fixer_app/view/Profile.dart';
import 'package:fixer_app/view/SignUp.dart';
import 'package:fixer_app/view/YourTasks.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String route = 'Home';
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final auth = FirebaseAuth.instance;
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
                            height: 100,
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
                          Column(
                            children: [
                              Text(
                                'Hi! ,Welcome Back!',
                                style: TextStyle(
                                  color: colors.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Profile.route);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 90,
                                      width: 700,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: const ListTile(
                                        title: Text(
                                          'Profile',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 58, 58),
                                              fontSize: 20),
                                        ),
                                        trailing: Icon(Icons.arrow_forward),
                                      ))),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, YourTask.route);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 90,
                                      width: 700,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          'Your Tasks',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 58, 58),
                                              fontSize: 20),
                                        ),
                                        trailing: Icon(Icons.arrow_forward),
                                      ))),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AssignTask.route);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 90,
                                      width: 700,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          'Assign Task',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 58, 58),
                                              fontSize: 20),
                                        ),
                                        trailing: Icon(Icons.arrow_forward),
                                      ))),
                              SizedBox(
                                height: 60,
                              ),
                              InkWell(
                                onTap: () async {
                                  await auth.signOut();
                                  Navigator.pushNamed(context, LoginView.route);
                                },
                                child: Text(
                                  'Log out',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                              )
                            ],
                          )
                        ])))));
  }
}
