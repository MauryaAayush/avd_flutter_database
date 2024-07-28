import 'package:avd_flutter_database/todo_app_withdb/controller/task_controller.dart';
import 'package:avd_flutter_database/todo_app_withdb/view/Components/add_task_dialoge.dart';
import 'package:avd_flutter_database/todo_app_withdb/view/Components/edit_task_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoApp extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  TodoApp({super.key});

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.teal;
      case 2:
        return Colors.teal.withOpacity(0.8);
      case 3:
        return Colors.teal.withOpacity(0.6);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's",
                        style: GoogleFonts.roboto(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Schedule",
                        style: GoogleFonts.roboto(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Sunday, July 28",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      List<String> weekDays = [
                        'M',
                        'T',
                        'W',
                        'T',
                        'F',
                        'S',
                        'S'
                      ];
                      return Column(
                        children: [
                          Text(
                            weekDays[index],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color:
                                  index == 6 ? Colors.teal : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${22 + index}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: Obx(() {
                  if (taskController.tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'There are no tasks',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: taskController.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskController.tasks[index];
                        return Card(
                          color: getPriorityColor(task.priority),
                          child: ListTile(
                            title: Text(
                              task.taskName,
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              task.note ?? '',
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.check),
                                  color: task.isDone
                                      ? Colors.transparent
                                      : Colors.black54,
                                  onPressed: () {
                                    taskController.toggleTaskStatus(task);
                                  },
                                ),
                                IconButton(
                                  color: task.isDone
                                      ? Colors.transparent
                                      : Colors.black54,
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditTaskDialog(task: task);
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  color: task.isDone
                                      ? Colors.transparent
                                      : Colors.black54,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    taskController.deleteTask(task.id!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                })),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: Colors.white),
                  Icon(Icons.calendar_today, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialog();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
