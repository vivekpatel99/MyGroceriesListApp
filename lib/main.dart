import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/wrapper.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/shared/theme.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/viewmodels/total_price_view_model.dart';
import 'package:provider/provider.dart';

// Todo add internet connection check
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TotalPriceViewModel>(
        create: (_) => TotalPriceViewModel(),
      ),
      ChangeNotifierProvider<CatagoryItemsViewModel>(
        create: (_) => CatagoryItemsViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = logger(MyApp);
    log.i('MyApp Started');
    log.d('----------- MyApp rebuild --------------------');
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // showPerformanceOverlay: true,
        title: "My Grocery App",
        debugShowCheckedModeBanner: false,
        theme: MyTheme.darkTheme(context),
        // darkTheme: ThemeData.dark(),
        home: Wrapper(),
      ),
    );
  }
}
