import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();
  TextEditingController todoDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: todoTitleController,
            decoration: const InputDecoration(
                labelText: 'Title', hintText: 'Write ToDo title'),
          ),
          TextField(
            controller: todoDescriptionController,
            decoration: const InputDecoration(
                labelText: 'Description', hintText: 'Write ToDo Description'),
          ),
          TextField(
            controller: todoDateController,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Write ToDo date',
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
