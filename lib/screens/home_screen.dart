import 'package:flutter/material.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';
import 'package:todo_list_sqf_lite/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kMintColor,
        title: const Text('TodoList SQFLite'),
      ),
      drawer: const DrawerNavigation(),
    );
  }
}
