import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/buy/buy_tab_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BoughtView extends StatelessWidget {
  const BoughtView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuyTabViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => BuyTabViewModel(),
    );
  }
}
