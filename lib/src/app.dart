import 'package:flutter/material.dart';
import 'package:todo_list_sqf_lite/constants/styling.dart';

import '../screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kDarkBlueColor,
          primary: kDarkBlueColor,
        ),
        fontFamily: 'Azonix',
      ),
      home: const HomeScreen(),
    );
  }
}
