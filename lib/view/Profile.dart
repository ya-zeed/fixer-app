import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer_app/Colors/colors.dart';
import 'package:fixer_app/view/Home.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const String route = 'Profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late String verificationId;

  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    loadPhoneNumber();
  }

  Future<void> loadPhoneNumber() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.email)
          .get();
      if (snapshot.exists) {
        setState(() {
          phoneNumber = snapshot.data()!['phone'];
          phoneController.text = phoneNumber ?? '';
        });
      }
    } catch (e) {
      print('Failed to load phone number: $e');
    }
  }

  Future<void> savePhone(String phoneNumber) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.email)
          .get();

      if (snapshot.exists && snapshot.data()?['phone'] != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('sorry'),
              content: Text('The phone number is already saved.'),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .set({'phone': phoneNumber});

      setState(() {
        this.phoneNumber = phoneNumber;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Phone number is saved'),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sorry'),
            content: Text(
              'The phone number could not be saved',
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, Home.route);
          },
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 50,
                      color: colors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 4, left: 8),
                  child: Text(
                    'Email address',
                    style: TextStyle(color: colors.mainColor, fontSize: 15),
                  ),
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
                    enabled: false,
                    controller: TextEditingController(text: user?.email ?? ''),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      hintStyle: const TextStyle(
                        height: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 4, left: 8),
                  child: Text(
                    'ID:',
                    style: TextStyle(color: colors.mainColor, fontSize: 15),
                  ),
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
                    onChanged: (value) {},
                    enabled: false,
                    controller:
                        TextEditingController(text: user?.displayName ?? ''),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      hintStyle: const TextStyle(
                        height: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 4, left: 8),
                  child: Text(
                    'Phone:',
                    style: TextStyle(color: colors.mainColor, fontSize: 15),
                  ),
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
                    onChanged: (value) {},
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter your Phone number',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      hintStyle: const TextStyle(
                        height: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: InkWell(
                      onTap: () {
                        String phoneNumber = phoneController.text;
                        savePhone(phoneNumber);
                        Navigator.pushNamed(context, Home.route);
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
                          'Save',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
