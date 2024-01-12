import 'package:flutter/material.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/service/category_service.dart';
import 'package:todo_list_sqf_lite/model/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();

  final _category = Category();
  final _categoryService = CategoryService();

  _showFormDialouge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;
                final result = await _categoryService.saveCategory(_category);
                print(result);
              },
              child: const Text('Save'),
            ),
          ],
          title: const Text('Categories Form'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Write a Category',
                    labelText: 'Category',
                  ),
                  controller: _categoryNameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Write a Description',
                    labelText: 'Description',
                  ),
                  controller: _categoryDescriptionController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kMintColor,
        title: const Text('Categories'),
      ),
      body: const Center(
        child: Text('Welcome to Categories screen!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialouge(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
