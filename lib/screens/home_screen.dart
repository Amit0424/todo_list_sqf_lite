import 'package:flutter/material.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/helpers/drawer_navigation.dart';
import 'package:todo_list_sqf_lite/screens/todo_screen.dart';
import 'package:todo_list_sqf_lite/service/todo_service.dart';

import '../model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TodoService _todoService;

  List<Todo> _todoList = [];

  @override
  void initState() {
    _getAllTodos();
    super.initState();
  }

  _getAllTodos() async {
    _todoService = TodoService();
    _todoList = [];

    final todos = await _todoService.readTodos();
    for (final todo in todos) {
      setState(() {
        final model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.isFinished = todo['isFinished'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kDarkBlueColor,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'TodoList SQFLite',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      drawer: const DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 5,
                shadowColor: kDarkBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_todoList[index].title ?? '------'),
                    ],
                  ),
                  subtitle: Text(_todoList[index].category ?? '----------'),
                  trailing: Text(_todoList[index].todoDate ?? '--------'),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const ToDoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
