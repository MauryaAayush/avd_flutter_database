import 'package:avd_flutter_database/todo_app_withdb/controller/task_controller.dart';
import 'package:avd_flutter_database/todo_app_withdb/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddTaskDialog extends StatelessWidget {
  final taskNameController = TextEditingController();
  final noteController = TextEditingController();
  final priorityController = TextEditingController();

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskNameController,
            decoration: InputDecoration(labelText: 'Task Name'),
          ),
          TextField(
            controller: noteController,
            decoration: InputDecoration(labelText: 'Note'),
          ),
          TextField(
            controller: priorityController,
            decoration: InputDecoration(labelText: 'Priority (1, 2, 3)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final task = Task(
              taskName: taskNameController.text,
              isDone: false,
              note: noteController.text,
              priority: int.parse(priorityController.text),
            );
            taskController.addTask(task);
            Get.back();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}