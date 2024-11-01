import 'dart:convert';

import 'package:simple_do/app/auth/data/models/app_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_do/app/tasks/data/models/tasks_model.dart';

class LocalStorage {
  static const String _tokenKey = 'token';
  static const String _languageKey = 'language';
  static const String _appUserKey = 'app_user';
  static const String _tasksKey = 'tasks';

  final SharedPreferences _sharedPreferences;

  LocalStorage(this._sharedPreferences);

  // Tasks
  Future<bool> storeTasks(TasksModel tasks) async {
    final thisTasks = this.tasks;
    thisTasks?.todos.addAll(tasks.todos);
    return _sharedPreferences.setString(
        _tasksKey, jsonEncode((thisTasks ?? tasks).toJson()));
  }

  TasksModel? get tasks {
    String? val = _sharedPreferences.getString(_tasksKey);
    if (val == null) {
      return null;
    }
    final tasks = TasksModel.fromJson(jsonDecode(val));
    return tasks;
  }

  Future<bool> clearTasks() async => _sharedPreferences.remove(_tasksKey);

  // Token
  Future<bool> storeToken(String token) async {
    return _sharedPreferences.setString(_tokenKey, token);
  }

  String? get token => _sharedPreferences.getString(_tokenKey);

  Future<bool> clearToken() async => _sharedPreferences.remove(_tokenKey);

  // User
  Future<bool> storeAppUser(AppUserModel user) async =>
      _sharedPreferences.setString(_appUserKey, jsonEncode(user.toJson()));

  AppUserModel? get appUser {
    String? val = _sharedPreferences.getString(_appUserKey);
    if (val == null) {
      return null;
    }
    return AppUserModel.fromJson(jsonDecode(val));
  }

  Future<bool> clearAppUser() async => _sharedPreferences.remove(_appUserKey);

  // Language
  Future<bool> storeLanguage(String lang) async =>
      _sharedPreferences.setString(_languageKey, lang);

  String? get language => _sharedPreferences.getString(_languageKey);

  Future<bool> clearLanguage() async => _sharedPreferences.remove(_languageKey);
}
