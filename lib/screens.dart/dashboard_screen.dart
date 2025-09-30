import 'package:flutter/material.dart';
import 'package:todo_app_ui/utils/app_color.dart';
import 'package:todo_app_ui/widgets/app_text.dart';
import 'package:todo_app_ui/widgets/text_field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ---- Task Data ----
  List<Map<String, dynamic>> tasks = [
    // {"task": "Learn programming", "time": "12am", "done": false},
    // {"task": "Learn how to cook", "time": "1pm", "done": false},
    // {"task": "Pick up the kids", "time": "2pm", "done": false},
  ];

  final TextEditingController _taskController = TextEditingController();
  TimeOfDay? _selectedTime;

  // ---- Dialog for adding new task ----
  void _addTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Task"),
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
                    child: Text(
                      _selectedTime == null
                          ? "No time selected"
                          : "Time: ${_selectedTime!.format(context)}",
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
                    child: const Text("Pick Time"),
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
              child: const Text("Cancel"),
            ),
            ElevatedButton(
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
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // ---- Top Header ----
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Appcolors.primarycolor,
                ),
                const Image(image: AssetImage("assets/images/shape (1).png")),
                Positioned(
                  top: 225,
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
            const SizedBox(height: 20),

            // ---- Daily Task Box ----
            Container(
              height: 300,
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
                            return Row(
                              children: [
                                Checkbox(
                                  value: task["done"],
                                  onChanged: (val) {
                                    setState(() {
                                      task["done"] = val!;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    "${task["task"]} by ${task["time"]}",
                                    style: TextStyle(
                                      decoration:
                                          task["done"]
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
