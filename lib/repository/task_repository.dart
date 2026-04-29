import 'package:mvvm_app/data/network/BaseApiServices.dart';
import 'package:mvvm_app/data/network/NetworkApiServices.dart';
import 'package:mvvm_app/res/app_url.dart';

class TaskRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  // Get All Tasks
  Future<dynamic> getTasksApi(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiServices(
        AppUrl.getTasksUrl,
        token: token,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Create Task
  Future<dynamic> createTaskApi(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.postApiServices(
        AppUrl.createTaskUrl,
        data,
        token: token,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Complete Task
  Future<dynamic> completeTaskApi(int id, String token) async {
    try {
      dynamic response = await _apiServices.patchApiServices(
        '${AppUrl.completeTaskUrl}/$id',
        token: token,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Delete Task
  Future<dynamic> deleteTaskApi(int id, String token) async {
    try {
      dynamic response = await _apiServices.deleteApiServices(
        '${AppUrl.deleteTaskUrl}/$id',
        token: token,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}