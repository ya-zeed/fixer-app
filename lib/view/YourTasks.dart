import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YourTask extends StatefulWidget {
  static const String route = 'TaskList';
  const YourTask({Key? key}) : super(key: key);

  @override
  _YourTaskState createState() => _YourTaskState();
}

class _YourTaskState extends State<YourTask> {
  final User? user = FirebaseAuth.instance.currentUser;

  late List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    getTasksFromFirestore();
  }

  void getTasksFromFirestore() async {
    try {
      var tasksSnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(user?.email)
          .get();

      if (tasksSnapshot.exists) {
        setState(() {
          tasks = List<String>.from(tasksSnapshot.data()?['tasks']);
        });
      }
    } catch (e) {
      print('Error retrieving tasks from Firestore: $e');
    }
  }

  void saveTasksToFirestore() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc('yazoid1421@gmail.com')
        .set({'tasks': tasks});

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Task saved successfully'),
        );
      },
    );
  }

  String newTask = '';

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
                      tasks.add(newTask);
                      saveTasksToFirestore();
                      newTask = '';
                    });
                  },
                  child: Text('Add Task'),
                ),
                SizedBox(height: 20),
                ...tasks
                    .map(
                      (task) => Card(
                        child: ListTile(
                          title: Text(task),
                          trailing: Icon(Icons.check_circle_outline),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget build(BuildContext context) {
  var tasks;
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
              ...tasks
                  .map((task) => Card(
                        child: ListTile(
                          title: Text(task),
                          trailing: Icon(Icons.check_circle_outline),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    ),
  );
}
