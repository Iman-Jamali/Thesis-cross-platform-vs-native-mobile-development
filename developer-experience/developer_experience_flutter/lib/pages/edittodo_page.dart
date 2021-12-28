import 'package:developer_experience_flutter/services/todo_api.dart';
import 'package:developer_experience_flutter/todo.dart';
import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  final String? todoId;
  EditTodoPage(this.todoId);

  @override
  _EditTodoPageState createState() => _EditTodoPageState(todoId);
}

class _EditTodoPageState extends State<EditTodoPage> {
  String? todoId;
  _EditTodoPageState(this.todoId);
  bool _isEdit = false;
  String _title = '';
  String _description = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (todoId != null) {
      _isEdit = true;
        TodoApi().getTodo(todoId!).then((todo) {
          _titleController.text = todo.title;
          _descriptionController.text = todo.description;
        }).catchError((error) {
          print(error);
        });
    } else {
      _isEdit = false;
    }
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
      validator: (value) => value!.isEmpty ? 'Title is required' : null,
      onSaved: (value) {
        _title = value!;
      },
      controller: _titleController,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
      validator: (value) => value!.isEmpty ? 'Description is required' : null,
      onSaved: (value) {
        _description = value!;
      },
      controller: _descriptionController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: _isEdit ? const Text('Edit Todo') : const Text('Add Todo')),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _buildTitle(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _buildDescription(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text('Cancel',
                              style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        _isEdit
                            ? ElevatedButton(
                                child: const Text('Delete',
                                    style: TextStyle(fontSize: 16)),
                                onPressed: () {
                                  _deleteTodo();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                              )
                            : Container(),
                        ElevatedButton(
                          child: 
                          Text(_isEdit ? 'Update' : 'Add', style: const TextStyle(fontSize: 16)),
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            _submittTodo();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  void _submittTodo() async {
    Todo todoItem =
        Todo(id: '', title: _title, description: _description, updatedAt: '');
    if (_isEdit) {
      await TodoApi().updateTodo(todoItem, todoId!);
    } else {
      await TodoApi().addTodo(todoItem);
    } 
    _goBack();
  }

  void _deleteTodo() async {
    await TodoApi().deleteTodo(todoId!);
    _goBack();
  }

  void _goBack() {
    Navigator.pop(context);
  }
}