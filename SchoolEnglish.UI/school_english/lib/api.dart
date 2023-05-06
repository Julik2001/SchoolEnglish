import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/models/register/registerDto.dart';

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
      var json = response.data["submodules"] as List;
      submodules = json.map((e) => Module.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return submodules;
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
}
