import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/wigets/item_card_list_tile.dart';
import 'package:my_grocery_list/wigets/item_list_view/item_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ItemListView extends StatelessWidget {
  // const ItemListView({Key? key}) : super(key: key);
  ItemListView({
    Key? key,
    required this.itemsListLen,
    required this.catagoryItems,
    required this.onBuyPage,
    required this.catagoryTitle,
  }) : super(key: key);

  final int itemsListLen;
  final List<Catagory> catagoryItems;

  final bool onBuyPage;
  final String catagoryTitle;
  final log = getLogger('ItemListView');

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemListViewModel>.nonReactive(
      builder: (context, model, child) => ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: itemsListLen,
        itemBuilder: (BuildContext context, int idx) {
          final String itemName = catagoryItems[idx].name;
          final bool toBuy = catagoryItems[idx].toBuy;
          final String quantity = catagoryItems[idx].quantity;
          final num price = catagoryItems[idx].price;
          log.i('ItemName $itemName & toBuy $toBuy');

          if (onBuyPage && toBuy) {
            model.updateItemPrice(itemName: itemName, price: price);
            // context
            //     .read<TotalPriceViewModel>()
            //     .addItemPrice(itemName: itemName, price: price);
            return ItemCardListTile(
              onBuyPage: onBuyPage,
              catagoryTitle: catagoryTitle,
              itemName: itemName,
              tobuy: toBuy,
              price: price,
              quantity: quantity,
            );
          } else if (!onBuyPage && !toBuy) {
            log.i('toBuy $toBuy');
            return ItemCardListTile(
              onBuyPage: onBuyPage,
              catagoryTitle: catagoryTitle,
              itemName: itemName,
              tobuy: toBuy,
              price: price,
              quantity: quantity,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      viewModelBuilder: () => ItemListViewModel(),
    );
  }
}
