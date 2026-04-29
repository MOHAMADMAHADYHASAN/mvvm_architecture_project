import 'package:flutter/material.dart';
import 'package:mvvm_app/model/task_model.dart';
import 'package:mvvm_app/repository/task_repository.dart';
import 'package:mvvm_app/utils/utils.dart';

class TaskViewModel with ChangeNotifier {
  final _taskRepo = TaskRepository();

  List<TaskModel> _tasks = [];
  bool _loading = false;

  List<TaskModel> get tasks => _tasks;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Get All Tasks
  Future<void> getTasks(String token, BuildContext context) async {
    setLoading(true);
    await _taskRepo.getTasksApi(token).then((value) {
      setLoading(false);
      final taskList = value['Task'] as List;
      _tasks = taskList.map((e) => TaskModel.fromJson(e)).toList();
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      utils.flashBarErrorMessage(error.toString(), context);
    });
  }

  // Create Task
  Future<void> createTask(dynamic data, String token, BuildContext context) async {
    await _taskRepo.createTaskApi(data, token).then((value) {
      utils.flashBarErrorMessage("Task created!", context);
      ///
      getTasks(token, context);
    }).onError((error, stackTrace) {
      utils.flashBarErrorMessage(error.toString(), context);
    });
  }

  // Complete Task
  Future<void> completeTask(int id, String token, BuildContext context) async {
    await _taskRepo.completeTaskApi(id, token).then((value) {
      //
      getTasks(token, context);
    }).onError((error, stackTrace) {
      utils.flashBarErrorMessage(error.toString(), context);
    });
  }

  // Delete Task
  Future<void> deleteTask(int id, String token, BuildContext context) async {
    await _taskRepo.deleteTaskApi(id, token).then((value) {
      utils.flashBarErrorMessage("Task deleted!", context);
      //
      getTasks(token, context);
    }).onError((error, stackTrace) {
      utils.flashBarErrorMessage(error.toString(), context);
    });
  }
}