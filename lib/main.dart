import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/home_page.dart';
import 'package:my_grocery_list/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Grocery App",
      debugShowCheckedModeBanner: false,
      theme: MyTheme.darkTheme(context),
      // darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
