


import 'package:avd_flutter_database/todo_app_withdb/controller/helper/databse_helper.dart';
import 'package:avd_flutter_database/todo_app_withdb/model/task_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TaskController extends GetxController {
  final tasks = <Task>[].obs;
  final dbHelper = DataBaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final data = await dbHelper.fetchTasks();
    tasks.value = data.map((task) => Task.fromMap(task)).toList();
  }

  Future<void> addTask(Task task) async {
    await dbHelper.insertTask(task.toMap());
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await dbHelper.updateTask(task.id!, task.toMap());
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await dbHelper.deleteTask(id);
    fetchTasks();
  }

  void toggleTaskStatus(Task task) {
    task.isDone = !task.isDone;
    updateTask(task);
  }
}
