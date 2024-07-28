import 'package:avd_flutter_database/todo_app_withdb/controller/task_controller.dart';
import 'package:avd_flutter_database/todo_app_withdb/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskDialog extends StatelessWidget {
  final Task task;

  final taskNameController = TextEditingController();
  final noteController = TextEditingController();
  final priorityController = TextEditingController();

  EditTaskDialog({super.key, required this.task}) {
    taskNameController.text = task.taskName;
    noteController.text = task.note ?? '';
    priorityController.text = task.priority.toString();
  }

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
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
            task.taskName = taskNameController.text;
            task.note = noteController.text;
            task.priority = int.parse(priorityController.text);
            taskController.updateTask(task);
            Get.back();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
