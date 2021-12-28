import 'dart:convert';
import 'package:developer_experience_flutter/todo.dart';
import 'package:http/http.dart' as http;

class TodoApi {
  static String apiBaseUrl = 'http://10.0.0.160:5000/api/v1';

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(apiBaseUrl + '/todos'));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body);
      List<Todo> todos =
          List<Todo>.from(l.map((model) => Todo.fromJson(model)));
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> getTodo(String id) async {
    final response =
        await http.get(Uri.parse(apiBaseUrl + '/todos/$id'));
    if (response.statusCode == 200) {
      Todo todo = Todo.fromJson(jsonDecode(response.body));
      return todo;
    } else {
      throw Exception('Failed to get todo');
    }
  }

  Future<void> addTodo(Todo newTodo) async {
    final response = await http.post(Uri.parse(apiBaseUrl + '/todos'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newTodo));
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to post todo');
    }
  }

  Future<void> updateTodo(Todo newTodo, String id) async {
    final response = await http.patch(
        Uri.parse(apiBaseUrl + '/todos/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newTodo));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response =
        await http.delete(Uri.parse(apiBaseUrl + '/todos/$id'));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
