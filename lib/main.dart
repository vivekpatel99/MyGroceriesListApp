import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:my_grocery_list/pages/home/home_view.dart';
import 'package:my_grocery_list/shared/setup_dialog_ui.dart';
import 'package:my_grocery_list/shared/theme.dart';
import 'package:stacked_services/stacked_services.dart';

// Todo add internet connection check
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupDialogUi();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = getLogger('MyApp');
    log.i('MyApp Started');
    log.d('-------------------- MyApp rebuild --------------------');
    return MaterialApp(
      // showPerformanceOverlay: true,
      title: "My Groceries App",
      debugShowCheckedModeBanner: false,
      theme: MyTheme.darkTheme(context),
      // darkTheme: ThemeData.dark(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      home: HomeView(),
    );
  }
}
