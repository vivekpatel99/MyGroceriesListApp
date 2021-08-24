import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/total_price/total_price_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TotalPriceView extends StatelessWidget {
  const TotalPriceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final log = getLogger('TotalPriceView');
    log.d('--------------------- TotalPriceView rebuild ---------------------');
    return ViewModelBuilder<TotalPriceViewModel>.reactive(
      builder: (context, model, child) => Text(
        '€ ${model.count.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 20.0,
        ),
      ),
      viewModelBuilder: () => TotalPriceViewModel(),
    );
  }
}
