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
  List<Map<String, dynamic>> tasks = [];

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
              onPressed: () {
                if (_taskController.text.isNotEmpty && _selectedTime != null) {
                  setState(() {
                    tasks.add({
                      "task": _taskController.text,
                      "time": _selectedTime!.format(context),
                      "done": false,
                    });
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

  //  Function to edit existing task
  void _editTaskDialog(int index) {
    _taskController.text = tasks[index]["task"];
    _selectedTime = null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: appText(
            text: "Edit Task",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            textcolor: Colors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appTextField(
                controller: _taskController,
                label: "Task",
                hintText: "Edit your task",
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: appText(
                      text:
                          _selectedTime == null
                              ? "Old Time: ${tasks[index]["time"]}"
                              : "New Time: ${_selectedTime!.format(context)}",
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
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  setState(() {
                    tasks[index]["task"] = _taskController.text;
                    if (_selectedTime != null) {
                      tasks[index]["time"] = _selectedTime!.format(context);
                    }
                  });
                  _taskController.clear();
                  _selectedTime = null;
                  Navigator.pop(context);
                }
              },
              text: "Save",
              height: 35,
              width: 90,
              backgroundcolor: Appcolors.primarycolor,
            ),
          ],
        );
      },
    );
  }

  //  Function to clear completed tasks
  void _clearCompletedTasks() {
    setState(() {
      tasks.removeWhere((task) => task["done"] == true);
    });
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

                  // Task List
                  Expanded(
                    child: ListView(
                      children:
                          tasks.map((task) {
                            int index = tasks.indexOf(task);
                            return Row(
                              children: [
                                Checkbox(
                                  checkColor: Appcolors.primarycolor,
                                  value: task["done"],
                                  onChanged: (val) {
                                    setState(() {
                                      task["done"] = val!;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: appText(
                                    text: "${task["task"]} by ${task["time"]}",
                                    decoration:
                                        task["done"]
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Appcolors.primarycolor,
                                  ),
                                  onPressed: () {
                                    _editTaskDialog(index);
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),

                  // Clear Completed Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: appButton(
                      onPressed: _clearCompletedTasks,
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
