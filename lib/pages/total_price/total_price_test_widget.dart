import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/total_price/total_price_viewmodel.dart';
import 'package:my_grocery_list/shared/styles.dart';
import 'package:stacked/stacked.dart';

class TotalPriceTextWidget extends ViewModelWidget<TotalPriceViewModel> {
  TotalPriceTextWidget({Key? key}) : super(key: key);
  final log = getLogger('TotalPriceView');
  @override
  Widget build(BuildContext context, TotalPriceViewModel model) {
    log.d('--------------------- TotalPriceView rebuild ---------------------');
    return Text(
      '€ ${model.count.toStringAsFixed(2)}',
      style: subheadingStyle,
    );
  }
}
