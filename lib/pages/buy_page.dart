import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/src/logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/item_card_list_tile.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';
import 'package:provider/provider.dart';
//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final log = logger(BuyPage);

  @override
  Widget build(BuildContext context) {
    try {
      final Map<String, dynamic>? myGroceryList =
          Provider.of<Map<String, dynamic>?>(context);

      return DisplayNestedListView(
          myGroceryList: myGroceryList ?? {}, onBuyPage: true);
    } catch (error) {
      log.e('$error');
      log.i('returning to Loading page');
      return const Loading();
    }
  }
}

class DisplayNestedListView extends StatelessWidget {
  DisplayNestedListView({
    Key? key,
    required this.myGroceryList,
    required this.onBuyPage,
  }) : super(key: key);

  final Map<String, dynamic> myGroceryList;
  final Logger log = logger(DisplayNestedListView);

  final bool onBuyPage;

  // bool _displayOnBuyPage(List<Catagory> items) {
  //   bool showItemOnPage = false;
  //   for (int i = 0; i < items.length; i++) {
  //     if (items[i].toBuy)
  //       print('################ _displayOnBuyPage ${items[i].toBuy}');
  //     return showItemOnPage = true;
  //   }
  //   return showItemOnPage;
  // }

  // bool _displayOnBoughtPage(List<Catagory> items) {
  //   bool showItemOnPage = false;
  //   for (int i = 0; i < items.length; i++) {
  //     if (!items[i].toBuy) print('################${items[i].toBuy}');
  //     return showItemOnPage = true;
  //   }
  //   return showItemOnPage;
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    final String userId = user?.uid ?? '';
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: myGroceryList.length,
              itemBuilder: (BuildContext context, int index) {
                final String catagoryTitle =
                    myGroceryList.keys.elementAt(index);
                final itemsListLen =
                    myGroceryList.values.elementAt(index)?.length as int;

                final items = myGroceryList.values.elementAt(index);
                final catagoryItems = items
                    .map<Catagory>((json) =>
                        Catagory.fromJson(json as Map<String, dynamic>))
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (catagoryTitle == null)
                        const SizedBox()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: null,
                              onLongPress: () {
                                DatabaseService(uid: userId).deleteCatagory(
                                    catagoryName: catagoryTitle);
                              },
                              child: Text(
                                catagoryTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PopUPAddItemWindow(
                                          onBuyPage: onBuyPage,
                                          catagoryName: catagoryTitle,
                                        );
                                      });
                                },
                                icon: const Icon(CupertinoIcons.add))
                          ],
                        ),
                      if (itemsListLen == 0)
                        // ||
                        //     (_displayOnBuyPage(catagoryItems as List<Catagory>) ==
                        //             true &&
                        //         !onBuyPage)
                        // ||
                        // (_displayOnBoughtPage(
                        //             catagoryItems as List<Catagory>) ==
                        //         true &&
                        //     onBuyPage)
                        // )
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No item',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      else
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: itemsListLen,
                              itemBuilder: (BuildContext context, int idx) {
                                final String itemName =
                                    catagoryItems[idx].name as String;
                                final bool toBuy =
                                    catagoryItems[idx].toBuy as bool;
                                final String quantity =
                                    catagoryItems[idx].quantity as String;
                                final double price =
                                    catagoryItems[idx].price as double;
                                log.i('ItemName $itemName & toBuy $toBuy');

                                if (onBuyPage && toBuy) {
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
                              }),
                        ),
                      // kDivider,
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
