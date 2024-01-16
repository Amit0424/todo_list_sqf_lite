import 'package:flutter/material.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/service/todo_service.dart';

import '../model/todo.dart';

class TodosByCategory extends StatefulWidget {
  const TodosByCategory({super.key, required this.category});
  final String category;

  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = [];

  final TodoService _todoService = TodoService();

  @override
  void initState() {
    _getTodosByCategories();
    super.initState();
  }

  _getTodosByCategories() async {
    final todos = await _todoService.readTodosByCategory(widget.category);
    _todoList = [];
    for (final todo in todos) {
      setState(() {
        final model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 5,
                shadowColor: kDarkBlueColor,
                child: ListTile(
                  title: Text(
                    _todoList[index].title ?? '-------',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    _todoList[index].description ?? '-------------',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    _todoList[index].todoDate ?? '--------',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
