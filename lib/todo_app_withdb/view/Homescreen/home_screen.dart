import 'package:avd_flutter_database/todo_app_withdb/controller/task_controller.dart';
import 'package:avd_flutter_database/todo_app_withdb/view/Components/add_task_dialoge.dart';
import 'package:avd_flutter_database/todo_app_withdb/view/Components/edit_task_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TodoApp extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  TodoApp({super.key});

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      body: Obx(() {
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
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(task.note ?? '',
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check),
                      color: task.isDone ? Colors.green : Colors.black54,
                      onPressed: () {
                        taskController.toggleTaskStatus(task);
                      },
                    ),
                    IconButton(
                      color: task.isDone ? Colors.green : Colors.black54,
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
                      color: task.isDone ? Colors.green : Colors.black54,
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
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



