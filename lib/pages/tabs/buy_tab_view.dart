import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/tabs/buy_tab_viewmodel.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/display_nested_list_view.dart';
import 'package:stacked/stacked.dart';

class BuyTabView extends StatelessWidget {
  BuyTabView({Key? key}) : super(key: key);
  final log = getLogger('BuyTabView');
  final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();
  @override
  Widget build(BuildContext context) {
    log.d('------------------------  BuyTabView ------------------------');
    return ViewModelBuilder<TabViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? const CircularProgressIndicator()
              : DisplayNestedListView(
                  groceryList: model.data, onBuyPage: true)),
      viewModelBuilder: () => TabViewModel(),
    );
  }
}
