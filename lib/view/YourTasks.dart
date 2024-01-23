import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YourTask extends StatefulWidget {
  static const String route = 'TaskList';
  const YourTask({Key? key}) : super(key: key);

  @override
  _YourTaskState createState() => _YourTaskState();
}

class _YourTaskState extends State<YourTask> {
  final User? user = FirebaseAuth.instance.currentUser;
  late Map<String, List<Map<String, String>>> tasksByDay = {};

  @override
  void initState() {
    super.initState();
    getTasksFromFirestore();
  }

  void getTasksFromFirestore() async {
    try {
      var tasksSnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(user?.displayName)
          .get();

      if (tasksSnapshot.exists) {
        var fetchedTasks = (tasksSnapshot.data()?['tasks'] ?? [])
            .map<Map<String, String>>((task) {
          return Map<String, String>.from(task as Map);
        }).toList();

        var groupedTasks = groupTasksByDay(fetchedTasks);
        setState(() {
          tasksByDay = groupedTasks;
        });
      }
    } catch (e) {
      print('Error retrieving tasks from Firestore: $e');
    }
  }

  Map<String, List<Map<String, String>>> groupTasksByDay(
      List<Map<String, String>> tasks) {
    Map<String, List<Map<String, String>>> grouped = {};
    for (var task in tasks) {
      String dayOfWeek =
          DateFormat('EEEE').format(DateTime.parse(task['dueDate']!));
      if (!grouped.containsKey(dayOfWeek)) {
        grouped[dayOfWeek] = [];
      }
      grouped[dayOfWeek]!.add(task);
    }
    return grouped;
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
                ...tasksByDay.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key, // Day of the week
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ...entry.value.map((task) => Card(
                            child: ListTile(
                              title: Text(task['task']!),
                              subtitle: Text(
                                  'Due: ${DateFormat('yyyy-MM-DD').format(DateTime.parse(task['dueDate']!))}'),
                              trailing: Icon(Icons.arrow_forward_rounded),
                            ),
                          )),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
