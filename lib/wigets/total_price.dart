import 'package:flutter/material.dart';
import 'package:my_grocery_list/viewmodels/total_price_view_model.dart';
import 'package:provider/provider.dart';

//--------------------------------------------------------------------------------------------
class TotalPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final num totalprice = context.watch<TotalPriceViewModel>().count;
    return Text(
      '€ ${totalprice.toString()}',
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
