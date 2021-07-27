import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/authenticate/authenticate.dart';
import 'package:my_grocery_list/pages/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print('#########');
    print(user?.uid);
    if (user == null) {
      return const Authenticate();
    } else {
      return HomePage();
    }
  }
}
