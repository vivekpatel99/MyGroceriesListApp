import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/tabs/buy_tab_viewmodel.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/display_nested_list_view.dart';
import 'package:stacked/stacked.dart';

class BoughtTabView extends StatelessWidget {
  BoughtTabView({Key? key}) : super(key: key);

  final log = getLogger('BoughtTabView');
  final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: StreamBuilder<Map<String, dynamic>?>(
          stream: model.stream,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.hasError) {
              log.e('StreamBuilder error ${snapshot.error}');
              return const SizedBox();
            } else {
              log.d('snapshot.data ${snapshot.data}');
              catagoryItemsViewModel.myGroceryList = snapshot.data;
              return DisplayNestedListView(
                  groceryList: snapshot.data, onBuyPage: false);
            }
          },
        ),
      ),
      viewModelBuilder: () => TabViewModel(),
    );
  }
}
