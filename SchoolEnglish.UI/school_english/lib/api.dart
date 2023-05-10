import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/models/register/registerDto.dart';
import 'package:school_english/models/role/role.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/models/task_part/taskpart.dart';
import 'package:school_english/models/task_part/taskpart_dto.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';

abstract class Api {
  static Dio _client = Dio();

  static getHeaders(String? jwt) => {"Authorization": "Bearer $jwt"};

  static Future<String?> login(String email, String password) async {
    const url = "$apiUrl/Auth/Login";
    try {
      var response =
          await _client.post(url, data: {"email": email, "password": password});
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<String?> register(RegisterDto registerDto) async {
    const url = "$apiUrl/Auth/Register";
    try {
      var response = await _client.post(url, data: registerDto.toJson());
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<String?> getTeacherCode() async {
    const url = "$apiUrl/Auth/GetTeacherCode";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<String?> getUserFullname() async {
    const url = "$apiUrl/Auth/GetUserFullname";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<bool> updateTeacherCode(String teacherCode) async {
    final url = "$apiUrl/Auth/UpdateTeacherCode/$teacherCode";
    try {
      final jwt = await LocalData.getJwt();
      await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return true;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<Module?> getModule(String moduleId) async {
    Module? module;
    final url = "$apiUrl/Module/GetModule/$moduleId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      module = Module.fromJson(json);
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return module;
  }

  static Future<List<Module>> getModules() async {
    List<Module> modules = [];
    const url = "$apiUrl/Module/GetModules";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data["modules"] as List;
      modules = json.map((e) => Module.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return modules;
  }

  static Future<List<Module>> getSubmodules(String moduleId) async {
    List<Module> submodules = [];
    final url = "$apiUrl/Module/GetSubmodules/$moduleId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data["modules"] as List;
      submodules = json.map((e) => Module.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return submodules;
  }

  static Future<String?> createOrUpdateModule(Module module) async {
    const url = "$apiUrl/Module/CreateOrUpdate";

    try {
      final jwt = await LocalData.getJwt();
      var response = await _client.post(url,
          data: module.toJson(), options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<bool> deleteModule(String moduleId) async {
    final url = "$apiUrl/Module/Delete/$moduleId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.delete(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      return true;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<Role?> getTeacherRole() async {
    const url = "$apiUrl/Role/GetTeacherRole";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return Role.fromJson(response.data);
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<Role?> getStudentRole() async {
    const url = "$apiUrl/Role/GetStudentRole";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return Role.fromJson(response.data);
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<bool> checkRoleIsTeacher() async {
    const url = "$apiUrl/Role/CheckRoleIsTeacher";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<bool> checkRoleIsStudent() async {
    const url = "$apiUrl/Role/CheckRoleIsStudent";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<bool> checkRoleIsModerator() async {
    const url = "$apiUrl/Role/CheckRoleIsModerator";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<List<Task>> getTasks(String moduleId) async {
    List<Task> tasks = [];
    final url = "$apiUrl/Task/GetTasksInModule/$moduleId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data["tasks"] as List;
      tasks = json.map((e) => Task.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return tasks;
  }

  static Future<Task?> getTask(String taskId) async {
    Task? task;
    final url = "$apiUrl/Task/GetTask/$taskId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      task = Task.fromJson(json);
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return task;
  }

  static Future<String?> createOrUpdateTask(Task task) async {
    const url = "$apiUrl/Task/CreateOrUpdate";

    try {
      final jwt = await LocalData.getJwt();
      var response = await _client.post(url,
          data: task.toJson(), options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<bool> deleteTask(String taskId) async {
    final url = "$apiUrl/Task/Delete/$taskId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.delete(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      return true;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<List<TaskPart>> getTaskParts(String taskId) async {
    List<TaskPart> taskParts = [];
    final url = "$apiUrl/TaskPart/GetTaskParts/$taskId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data["parts"] as List;
      taskParts = json.map((e) => TaskPart.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return taskParts;
  }

  static Future<TaskPart?> getTaskPart(String taskPartId) async {
    TaskPart? task;
    final url = "$apiUrl/TaskPart/GetTaskPartWithContent/$taskPartId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      task = TaskPart.fromJson(json);
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return task;
  }

  static Future<String?> createOrUpdateTaskPart(
      TaskPartDto taskPart, File? image, File? audio) async {
    const url = "$apiUrl/TaskPart/CreateOrUpdate";

    try {
      final jwt = await LocalData.getJwt();
      final data = taskPart.toJson();
      if (image != null) {
        data.addAll({
          "imageFile": await MultipartFile.fromFile(image.path,
              filename: basename(image.path))
        });
      }
      if (audio != null) {
        data.addAll({
          "audioFile": await MultipartFile.fromFile(audio.path,
              filename: basename(audio.path))
        });
      }

      var fromData = FormData.fromMap(data);
      var response = await _client.post(url,
          data: fromData, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
  }

  static Future<bool> deleteTaskPart(String taskPartId) async {
    final url = "$apiUrl/TaskPart/Delete/$taskPartId";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.delete(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data;
      return true;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<List<TaskPartContentType>> getTaskPartContentTypes() async {
    List<TaskPartContentType> tasks = [];
    const url = "$apiUrl/TaskPartContentType/GetTypes";

    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      var json = response.data["contentTypes"] as List;
      tasks = json.map((e) => TaskPartContentType.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return tasks;
  }

  static Future<bool> checkTypeHasImage(String typeId) async {
    final url = "$apiUrl/TaskPartContentType/CheckTypeHasImage/$typeId";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<bool> checkTypeHasTextToRead(String typeId) async {
    final url = "$apiUrl/TaskPartContentType/CheckTypeHasTextToRead/$typeId";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<bool> checkTypeHasAnswerVariants(String typeId) async {
    final url =
        "$apiUrl/TaskPartContentType/CheckTypeHasAnswerVariants/$typeId";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }

  static Future<bool> checkTypeHasAudio(String typeId) async {
    final url = "$apiUrl/TaskPartContentType/CheckTypeHasAudio/$typeId";
    try {
      final jwt = await LocalData.getJwt();
      var response =
          await _client.get(url, options: Options(headers: getHeaders(jwt)));
      return response.data;
    } catch (ex) {
      debugPrint(ex.toString());
      return false;
    }
  }
}
