import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/wrapper.dart';
import 'package:my_grocery_list/providers/total_total_counter.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/shared/theme.dart';
import 'package:provider/provider.dart';

// todo add internet connection check
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TotalPriceCounter())],
    child: MyApp(),
  ));

  // runApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = logger(MyApp);
    log.i('MyApp Started');
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: "My Grocery App",
        debugShowCheckedModeBanner: false,
        theme: MyTheme.darkTheme(context),
        // darkTheme: ThemeData.dark(),
        home: Wrapper(),
      ),
    );
  }
}
