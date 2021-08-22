import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/total_price/total_price_view_model.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:provider/provider.dart';
//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final log = logger(BuyPage);

  @override
  Widget build(BuildContext context) {
    log.i('----------------- BuyPage reBuild ------------------');
    context.read<TotalPriceViewModel>().reset();
    try {
      return const SizedBox(); //DisplayNestedListView(onBuyPage: true);
    } catch (error) {
      log.e('$error');
      log.i('returning to Loading page');
      return const Loading();
    }
  }
}
