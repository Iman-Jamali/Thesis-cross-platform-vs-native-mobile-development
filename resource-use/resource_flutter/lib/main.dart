import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:resource_flutter/Todo.dart';
import 'package:resource_flutter/id.dart';
import 'dart:convert';

import 'package:resource_flutter/message.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Resource Use Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    int startTime = DateTime.now().millisecondsSinceEpoch;
                    var primes = [];
                    primes = findPrimes(300000);
                    int endTime = DateTime.now().millisecondsSinceEpoch;
                    print(
                        'Test A duration: ' + (endTime - startTime).toString());
                  },
                  child: const Text('Test A'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    int startTime = DateTime.now().millisecondsSinceEpoch;
                    int min = 0;
                    int max = 1;
                    int n = 400;
                    int m = 200000;
                    var graph = List.generate(m, (i) => List<int>.filled(n, 0),
                        growable: false);
                    for (int i = 0; i < m; i++) {
                      var v = List<int>.filled(n, 0);
                      for (int j = 0; j < n; j++) {
                        int randomNum =
                            min + new Random().nextInt(max - min + 1);
                        v[j] = randomNum;
                      }
                      graph[i] = v;
                    }
                    transitiveClosure(graph, n);
                    int endTime = DateTime.now().millisecondsSinceEpoch;
                    print(
                        'Test B duration: ' + (endTime - startTime).toString());
                  },
                  child: const Text('Test B'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    int startTime = DateTime.now().millisecondsSinceEpoch;
                    await Future.wait(networkTest(100));
                    int endTime = DateTime.now().millisecondsSinceEpoch;
                    print(
                        'Test C duration: ' + (endTime - startTime).toString());
                  },
                  child: const Text('Test C'),
                ),
              ],
            ),
          ),
        ));
  }

  isPrime(int num) {
    for (int i = 2; i < num; i++) {
      if (num % i == 0) {
        return false;
      }
    }
    return num > 1;
  }

  findPrimes(int maxNum) {
    var primes = [];
    for (int i = 1; i <= maxNum; i++) {
      if (isPrime(i)) {
        primes.add(i);
      }
    }
    return primes;
  }

  transitiveClosure(List<List<int>> graph, int V) {
    var reach =
        List.generate(V, (i) => List<int>.filled(V, 0), growable: false);
    var i, j, k;

    for (i = 0; i < V; i++) {
      for (j = 0; j < V; j++) {
        reach[i][j] = graph[i][j];
      }
    }

    for (k = 0; k < V; k++) {
      for (i = 0; i < V; i++) {
        for (j = 0; j < V; j++) {
          reach[i][j] =
              (reach[i][j] != 0) || ((reach[i][k] != 0) && (reach[k][j] != 0))
                  ? 1
                  : 0;
        }
      }
    }
  }

  List<Future> networkTest(num) {
    List<Future> futures = [];
    Todo newTodo =
        Todo(id: "1", title: "title 1", description: "description 1");
    var client = http.Client();

    for (int i = 0; i < num; i++) {
      futures.add(fetchTodo(client));
      futures.add(postTodo(client, newTodo));
      futures.add(patchTodo(client, newTodo));
      futures.add(deleteTodo(client));
    }
    return futures;
  }

  Future<Todo> fetchTodo(client) async {
    try {
      final response = await client.get(Uri.parse('http://10.0.0.160:5000/todos/1'));
      if (response.statusCode == 200) {
        return Todo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get todo');
      }
    } finally {
      // client.close();
    }
  }

  Future<Message> postTodo(client,newTodo) async {
    try {
      final response = await client.post(
          Uri.parse(
            'http://10.0.0.160:5000/todos',
          ),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(newTodo));
      if (response.statusCode == 201) {
        return Message.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to post todo');
      }
    } 
    finally {
      // client.close();
    }
  }

  Future<Id> patchTodo(client, newTodo) async {
    try {
      final response = await client.patch(
          Uri.parse(
            'http://10.0.0.160:5000/todos/1',
          ),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(newTodo));
      if (response.statusCode == 200) {
        return Id.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to patch todo');
      }
    } finally {
      // client.close();
    }
  }

  Future<Id> deleteTodo(client) async {
    try {
      final response = await client.delete(Uri.parse(
        'http://10.0.0.160:5000/todos/1',
      ));
      if (response.statusCode == 200) {
        return Id.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete todo');
      }
    } finally {
      // client.close();
    }
  
  }
}
