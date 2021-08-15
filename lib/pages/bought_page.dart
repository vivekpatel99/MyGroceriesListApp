import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/shared/logging.dart';

class BoughtPage extends StatelessWidget {
  final log = logger(BoughtPage);
  @override
  Widget build(BuildContext context) {
    try {
      return DisplayNestedListView(onBuyPage: false);
    } catch (error) {
      log.e('$error');
      log.i('Returning to Loading page');
      return const Loading();
    }
  }
}
