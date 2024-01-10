import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignTask extends StatefulWidget {
  static const String route = 'AssignTask';
  const AssignTask({Key? key}) : super(key: key);

  @override
  _AssignTaskState createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  String newTask = '';
  String userEmail = ''; // New variable for storing user email

  void saveTasksToFirestore() async {
    if (userEmail.isNotEmpty) {
      await FirebaseFirestore.instance.collection('tasks').doc(userEmail).set({
        'tasks': FieldValue.arrayUnion([newTask])
      }, SetOptions(merge: true));

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Task saved successfully'),
          );
        },
      );
    } else {
      // Handle the case when email is not entered
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please enter an email address'),
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Your Tasks'),
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
                SizedBox(height: 20),
                Text(
                  'Your Tasks',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      userEmail = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      newTask = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'New Task',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      saveTasksToFirestore();
                      newTask = '';
                    });
                  },
                  child: Text('Add Task'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
