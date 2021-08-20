import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/viewmodels/total_price_view_model.dart';
import 'package:provider/provider.dart';

//--------------------------------------------------------------------------------------------
class TotalPriceTextWidget extends StatelessWidget {
  final log = logger(TotalPriceTextWidget);
  @override
  Widget build(BuildContext context) {
    log.d('----------- HomePage rebuild --------------------');
    final num totalprice = context.watch<TotalPriceViewModel>().count;
    log.i('totalprice $totalprice');
    return Text(
      '€ ${totalprice.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
