import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart'
    as myconst;
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/item_card_list_tile.dart';
import 'package:provider/provider.dart';

class BoughtPage extends StatelessWidget {
  final log = logger(BoughtPage);
  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<Map<String, dynamic>?>(context);
      log.d('myGroceryList : $myGroceryList');
      final Map<String, dynamic>? sortedMyGroceryList =
          myconst.shortedMyGroceryList(myGroceryList: myGroceryList);

      return DisplayNestedListView(
          myGroceryList: sortedMyGroceryList ?? {}, onBuyPage: false);
    } catch (error) {
      log.e('$error');
      log.i('Returning to Loading page');
      return const Loading();
    }
  }
}

class _CatagorySectionBoughtpage extends StatefulWidget {
  const _CatagorySectionBoughtpage({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;

  @override
  __CatagorySectionBoughtpageState createState() =>
      __CatagorySectionBoughtpageState();
}

class __CatagorySectionBoughtpageState
    extends State<_CatagorySectionBoughtpage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final log = logger(_CatagorySectionBoughtpage);
    bool undoAction = true;
    final List<dynamic> _itemList = widget.itemList ?? [];
    final String userId = user?.uid ?? '';
    final itemListMap = _itemList.map((_list) => _list.toJson()).toList();
    log.d('itemListMap : $itemListMap');
    log.d('itemListMap.length : ${itemListMap.length}');

    bool _isAllItemFalse({required List<dynamic> itemlist}) {
      final bool restult =
          itemListMap.every((e) => e.containsValue(true) as bool);
      return restult;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.catagory.catagoryName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (itemListMap.isEmpty)
            const Text("No Items")
          else if (_isAllItemFalse(itemlist: itemListMap))
            const Text("No Items")
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemListMap.length,
              itemBuilder: (BuildContext context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: secondaryBackground(
                      mainAxisAlignment: MainAxisAlignment.start),
                  secondaryBackground: dismissibleBackground(
                      mainAxisAlignment: MainAxisAlignment.end,
                      msgText: 'Move to Buy'),
                  confirmDismiss: (DismissDirection dismissDirection) async {
                    // https://flutter.dev/docs/cookbook/design/snackbars
                    // https://stackoverflow.com/questions/64135284/how-to-achieve-delete-and-undo-operations-on-dismissible-widget-in-flutter

                    if (dismissDirection == DismissDirection.endToStart) {
                      myconst.simpleSnackBar(
                          context: context,
                          displayMsg: '1 item moved to buy',
                          onPressed: () {
                            undoAction = false;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            setState(() {});
                          });
                      log.i('${itemListMap[index][kName]} moved to buy');
                    } else {
                      myconst.simpleSnackBar(
                          context: context,
                          displayMsg: '1 item moved to trash',
                          onPressed: () {
                            undoAction = false;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            setState(() {});
                          });
                      log.i('${itemListMap[index][kName]} moved to trash');
                    }

                    return true;
                  },
                  onDismissed: (DismissDirection direction) async {
                    // added delay to get updated value of undoAction
                    await Future.delayed(const Duration(seconds: 5));

                    if (direction == DismissDirection.endToStart) {
                      if (undoAction) {
                        itemListMap[index][kToBuy] = true;
                        await DatabaseService(uid: userId).moveToBuyBought(
                          catagoryName: widget.catagory.catagoryName,
                          mapList: itemListMap,
                        );
                      }
                    } else {
                      if (undoAction) {
                        await DatabaseService(uid: userId)
                            .deleteItemFromCataogry(
                          catagoryName: widget.catagory.catagoryName,
                          mapList: itemListMap[index],
                        );
                      }
                    }
                  },
                  child: ItemCardListTile(
                    tobuy: !(itemListMap[index][kToBuy] as bool),
                    itemName: itemListMap[index][kName].toString(),
                    price: 1.99,
                    quantity: '',
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
