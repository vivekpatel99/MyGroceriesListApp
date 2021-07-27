import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/wrapper.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: "My Grocery App",
        debugShowCheckedModeBanner: false,
        theme: MyTheme.darkTheme(context),
        // darkTheme: ThemeData.dark(),
        home: const Wrapper(),
      ),
    );
  }
}
