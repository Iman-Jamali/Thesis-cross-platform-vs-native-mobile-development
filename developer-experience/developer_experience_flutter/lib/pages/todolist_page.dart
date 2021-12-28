import 'package:developer_experience_flutter/pages/edittodo_page.dart';
import 'package:developer_experience_flutter/services/todo_api.dart';
import 'package:developer_experience_flutter/todo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = TodoApi().getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var todo = snapshot.data![index];
                return _buildTodoList(context, todo);
              },
            );
          } else {
            return const Center(
                child: Text("No data", textAlign: TextAlign.center));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleAddTodo(context);
        },
        child: const Text("Add"),
      ),
    );
  }

  void handleAddTodo(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditTodoPage(null);
    })).then((value) => setState(() {
          _todos = TodoApi().getTodos();
        }));
  }

  Widget _buildTodoList(BuildContext context, todo) {
    var date = DateTime.parse(todo.updatedAt).toLocal();
    var updatedAt = DateFormat('yyyy-MM-dd, HH:mm:ss').format(date);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          handleItemClicked(context, todo);
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(todo.title,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(updatedAt , style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(todo.description,
                          style: const TextStyle(fontSize: 18.0)),
                    ],
                  ),
                )
              ],
            )));
  }

  void handleItemClicked(BuildContext context, todo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditTodoPage(todo.id);
    })).then((value) => setState(() {
          _todos = TodoApi().getTodos();
        }));
  }
}
