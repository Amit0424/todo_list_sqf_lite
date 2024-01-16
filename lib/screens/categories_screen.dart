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
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();

  final _category = Category();
  final _categoryService = CategoryService();
  late var category;

  List<Category> _categoryList = [];

  @override
  void initState() {
    getAllCategories();
    super.initState();
  }

  getAllCategories() async {
    final categories = await _categoryService.readCategories();
    _categoryList = [];
    for (var category in categories) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    }
  }

  _showSuccessSnackbar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: kDarkBlueColor,
    ));
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoriesById(categoryId);
    _categoryNameController.text = category[0]['name'] ?? 'No Name';
    _categoryDescriptionController.text =
        category[0]['description'] ?? 'No Description';
  }

  _showFormDialouge(
      BuildContext context, String buttonName, String dialogName) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _categoryNameController.clear();
                _categoryDescriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var result;
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;
                if (buttonName == 'Update') {
                  _category.id = category[0]['id'];
                  result = await _categoryService.updateCategory(_category);
                } else {
                  result = await _categoryService.saveCategory(_category);
                }
                print(result);
                _categoryNameController.clear();
                _categoryDescriptionController.clear();
                Navigator.pop(context);
                getAllCategories();
                _showSuccessSnackbar('${buttonName}d Successfully');
              },
              child: Text(buttonName),
            ),
          ],
          title: Text(dialogName),
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

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
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
                  final result =
                      await _categoryService.deleteCategory(categoryId);
                  Navigator.pop(context);
                  getAllCategories();
                  _showSuccessSnackbar('Deleted Successfully');
                },
                child: const Text('Delete'),
              ),
            ],
            title: const Text('Delete Category'),
          );
        });
  }

  @override
  void dispose() {
    _categoryNameController;
    _categoryDescriptionController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      // backgroundColor: kWhiteColor,
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
          'Categories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Card(
                elevation: 5,
                shadowColor: kDarkBlueColor,
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                      _showFormDialouge(
                          context, 'Update', 'Edit Categories Form');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(_categoryList[index].name ?? '--------'),
                  subtitle:
                      Text(_categoryList[index].description ?? '-------------'),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, _categoryList[index].id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialouge(context, 'Save', 'Categories Form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
