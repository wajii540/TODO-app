import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/elevatedbutton.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Firestore and Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _taskController = TextEditingController();
  TimeOfDay? _selectedTime;

  //  Function to add new task
  void _addTaskDialog() {
    _taskController.clear();
    _selectedTime = null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: appText(
            text: "Add Task",
            fontSize: 30,
            fontWeight: FontWeight.w700,
            textcolor: Colors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appTextField(
                controller: _taskController,
                label: "Task",
                hintText: "Enter your task",
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: appText(
                      text:
                          _selectedTime == null
                              ? "No time selected"
                              : "Time: ${_selectedTime!.format(context)}",
                      fontSize: 15,
                      textcolor: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      }
                    },
                    child: appText(
                      text: "Pick Time",
                      fontSize: 15,
                      textcolor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: appText(
                text: "Cancel",
                fontSize: 15,
                textcolor: Colors.black,
              ),
            ),
            appButton(
              onPressed: () async {
                final user = _auth.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Not authenticated')),
                  );
                  return;
                }
                if (_taskController.text.isNotEmpty && _selectedTime != null) {
                  await _firestore
                      .collection('users')
                      .doc(user.uid)
                      .collection('tasks')
                      .add({
                        'task': _taskController.text,
                        'time': _selectedTime!.format(context),
                        'done': false,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                  _taskController.clear();
                  _selectedTime = null;
                  Navigator.pop(context);
                }
              },
              text: "Add",
              height: 35,
              width: 90,
              backgroundcolor: Appcolors.primarycolor,
            ),
          ],
        );
      },
    );
  }

  // ...edited: individual item edit handled inline in the list

  //  Function to clear completed tasks
  Future<void> _clearCompletedTasks() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final completed =
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('tasks')
            .where('done', isEqualTo: true)
            .get();
    for (final doc in completed.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Top Header
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Appcolors.primarycolor,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const Image(image: AssetImage("assets/images/shape (1).png")),
                Positioned(
                  top: 120,
                  left: 100,
                  right: 100,
                  child: appText(
                    text: "Welcome Mary!",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    textcolor: Appcolors.c0xFFE6E6E6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Image(image: AssetImage("assets/images/Group 162.png")),
            const SizedBox(height: 40),

            // ---- Daily Task Box ----
            Container(
              height: 350,
              width: 335,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appText(
                        text: "Daily Task",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textcolor: Appcolors.lighttextcolor,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Appcolors.primarycolor,
                          size: 30,
                        ),
                        onPressed: _addTaskDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Task List (from Firestore)
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          _auth.currentUser == null
                              ? const Stream.empty()
                              : _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('tasks')
                                  .orderBy('createdAt', descending: true)
                                  .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: appText(text: 'No tasks'));
                        }
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, i) {
                            final doc = docs[i];
                            final data = doc.data();
                            return Row(
                              children: [
                                Checkbox(
                                  checkColor: Appcolors.primarycolor,
                                  value: data['done'] ?? false,
                                  onChanged: (val) async {
                                    await doc.reference.update({'done': val});
                                  },
                                ),
                                Expanded(
                                  child: appText(
                                    text: "${data['task']} by ${data['time']}",
                                    decoration:
                                        data['done'] == true
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Appcolors.primarycolor,
                                  ),
                                  onPressed: () async {
                                    // prefill controller with existing text
                                    _taskController.text = data['task'] ?? '';
                                    _selectedTime = null;
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: appText(
                                            text: 'Edit Task',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            textcolor: Colors.black,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              appTextField(
                                                controller: _taskController,
                                                label: 'Task',
                                                hintText: 'Edit your task',
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: appText(
                                                      text:
                                                          _selectedTime == null
                                                              ? 'Old Time: ${data['time'] ?? ''}'
                                                              : 'New Time: ${_selectedTime!.format(context)}',
                                                      fontSize: 15,
                                                      textcolor: Colors.black,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      final TimeOfDay? picked =
                                                          await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                          );
                                                      if (picked != null) {
                                                        setState(() {
                                                          _selectedTime =
                                                              picked;
                                                        });
                                                      }
                                                    },
                                                    child: appText(
                                                      text: 'Pick Time',
                                                      fontSize: 15,
                                                      textcolor: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: appText(
                                                text: 'Cancel',
                                                fontSize: 15,
                                                textcolor: Colors.black,
                                              ),
                                            ),
                                            appButton(
                                              onPressed: () async {
                                                final newTask =
                                                    _taskController.text;
                                                if (newTask.isNotEmpty) {
                                                  final updateData =
                                                      <String, dynamic>{
                                                        'task': newTask,
                                                      };
                                                  if (_selectedTime != null) {
                                                    updateData['time'] =
                                                        _selectedTime!.format(
                                                          context,
                                                        );
                                                  }
                                                  await doc.reference.update(
                                                    updateData,
                                                  );
                                                  _taskController.clear();
                                                  _selectedTime = null;
                                                  Navigator.pop(context);
                                                }
                                              },
                                              text: 'Save',
                                              height: 35,
                                              width: 90,
                                              backgroundcolor:
                                                  Appcolors.primarycolor,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await doc.reference.delete();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Clear Completed Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: appButton(
                      onPressed: () async {
                        await _clearCompletedTasks();
                      },
                      text: "Clear ",
                      height: 35,
                      width: 90,
                      backgroundcolor: Appcolors.primarycolor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
