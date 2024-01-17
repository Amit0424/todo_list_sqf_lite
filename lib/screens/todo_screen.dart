import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/model/todo.dart';
import 'package:todo_list_sqf_lite/service/category_service.dart';
import 'package:todo_list_sqf_lite/service/todo_service.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescriptionController = TextEditingController();
  final TextEditingController _todoDateController = TextEditingController();

  String? _selectedValue;
  final List<DropdownMenuItem> _categories = [];
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  _showSuccessSnackbar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      backgroundColor: kDarkBlueColor,
    ));
  }

  _loadCategories() async {
    final categoryService = CategoryService();
    final categories = await categoryService.readCategories();
    for (var category in categories) {
      setState(() {
        _categories.add(DropdownMenuItem(
          value: category['name'],
          child: Text(category['name']),
        ));
      });
    }
  }

  _selectedTodoDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null){
      setState(() {
        _dateTime = pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
        title: const Text(
          'Create Todo',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _todoTitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Write ToDo title',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Write ToDo Description',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Pick a date',
                hintStyle: const TextStyle(fontSize: 12),
                prefixIcon: IconButton(
                  onPressed: () {_selectedTodoDate(context);},
                  icon: const Icon(Icons.calendar_month_rounded),
                ),
              ),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              hint: Text(
                'Category',
                style: TextStyle(
                  color: kDarkBlueColor,
                ),
              ),
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final todoObject = Todo();

                todoObject.title = _todoTitleController.text;
                todoObject.description = _todoDescriptionController.text;
                todoObject.todoDate = _todoDateController.text;
                todoObject.category = _selectedValue.toString();
                todoObject.isFinished = 0;

                final todoService = TodoService();
                final result = await todoService.saveTodo(todoObject);

                if(result > 0){
                  _todoTitleController.clear();
                  _todoDateController.clear();
                  _todoDescriptionController.clear();
                  _selectedValue = null;
                  _showSuccessSnackbar('Created');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkBlueColor,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
