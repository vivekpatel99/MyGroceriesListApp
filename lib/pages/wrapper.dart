import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (user == null) {
    return Authenticate();
    // } else {
    // return HomePage();
    // }
  }
}
