import 'package:avd_flutter_database/todo_app_withdb/controller/task_controller.dart';
import 'package:avd_flutter_database/todo_app_withdb/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoApp extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

   TodoApp({super.key});

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
                title: Text(task.taskName),
                subtitle: Text(task.note ?? ''),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    taskController.toggleTaskStatus(task);
                  },
                ),
                onLongPress: () {
                  taskController.deleteTask(task.id!);
                },
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
}

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
