import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/screens/todos_by_category.dart';
import 'package:todo_list_sqf_lite/service/category_service.dart';
import 'package:todo_list_sqf_lite/screens/categories_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = [];

  final CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    _getAllCategories();
    super.initState();
  }

  _getAllCategories() async {
    final categories = await _categoryService.readCategories();
    _categoryList = [];
    for (var category in categories) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => TodosByCategory(
                  category: category['name'],
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  'https://firebasestorage.googleapis.com/v0/b/coffee-cafe-app-45ff3.appspot.com/o/partner_document_media%2Ft9oEGkT294aYXHagI5g9RKrAlAD2%2FprofileImage%2FIMG20221101102223.jpg?alt=media&token=c0df46d9-9c3f-4441-b035-2b2885238baf'),
            ),
            accountName: const Text(
              'Amit Choudhary',
              style: TextStyle(fontSize: 16),
            ),
            accountEmail: const Text(
              'amitjat2406@gmail.com',
              style: TextStyle(fontSize: 12),
            ),
            decoration: BoxDecoration(
              color: kDarkBlueColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text(
              'Categories',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const CategoriesScreen(),
                ),
              );
            },
          ),
          const Divider(),
          Column(
            children: _categoryList,
          )
        ],
      ),
    );
  }
}
