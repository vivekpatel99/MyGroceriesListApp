import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/total_price/total_price_view_model.dart';
import 'package:stacked/stacked.dart';

class TotalPriceView extends StatelessWidget {
  const TotalPriceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalPriceViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => TotalPriceViewModel(),
    );
  }
}
