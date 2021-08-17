import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/viewmodels/total_price_view_model.dart';
import 'package:my_grocery_list/wigets/display_nested_list_view.dart';
import 'package:provider/provider.dart';

class BoughtPage extends StatelessWidget {
  final log = logger(BoughtPage);
  @override
  Widget build(BuildContext context) {
    // context.read<TotalPriceViewModel>().reset();
    context.read<TotalPriceViewModel>().reset();
    try {
      return DisplayNestedListView(onBuyPage: false);
    } catch (error) {
      log.e('$error');
      log.i('Returning to Loading page');
      return const Loading();
    }
  }
}
