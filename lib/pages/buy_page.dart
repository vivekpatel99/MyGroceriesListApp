import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/wigets/display_nested_list_view.dart';
//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final log = logger(BuyPage);

  @override
  Widget build(BuildContext context) {
    try {
      return DisplayNestedListView(onBuyPage: true);
    } catch (error) {
      log.e('$error');
      log.i('returning to Loading page');
      return const Loading();
    }
  }
}
