import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todolist/models/todo.dart';

class ToDoProvider {
  static const String _keyToDoList = 'todo_list';

  // Save the to-do list to SharedPreferences
  static Future<void> saveToDoList(List<ToDo> toDoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> toDoJsonList = toDoList.map((todo) => jsonEncode(todo.toMap())).toList();
    prefs.setStringList(_keyToDoList, toDoJsonList);
  }

  // Retrieve the to-do list from SharedPreferences
  static Future<List<ToDo>> getToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? toDoJsonList = prefs.getStringList(_keyToDoList);

    if (toDoJsonList == null) {
      return [];
    } else {
      return toDoJsonList.map((toDoJson) => ToDo.fromMap(jsonDecode(toDoJson))).toList();
    }
  }
}
