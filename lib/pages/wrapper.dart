import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/authenticate/authenticate.dart';
import 'package:my_grocery_list/pages/home/home_page_view.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final log = logger(Wrapper);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    log.d('----------- Wrapper rebuild --------------------');
    if (user == null) {
      log.i('Authenticate Page opens');
      return const Authenticate();
    } else {
      log.i('Homepage Page opens');
      return HomePageView();
    }
  }
}
