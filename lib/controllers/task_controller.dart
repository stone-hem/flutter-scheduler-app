import 'package:get/get.dart';
import 'package:scheduler/db/db_helper.dart';
import 'package:scheduler/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  void getTasks() async {
    print("getting tasks...");
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void remove(Task task) {
    DbHelper.remove(task);
  }

  void tickTask(int id) async {
    await DbHelper.update(id);
  }
}
