import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/src/logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart'
    as myconst;
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/item_card_list_tile.dart';
import 'package:provider/provider.dart';
//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final log = logger(BuyPage);

  @override
  Widget build(BuildContext context) {
    try {
      Map<String, dynamic>? myGroceryList =
          Provider.of<Map<String, dynamic>?>(context);
      // Map<String, dynamic> sortedMyGroceryList;
      // if (myGroceryList != null) {
      //   sortedMyGroceryList = Map.fromEntries(myGroceryList.entries.toList()
      //     ..sort((e1, e2) => e1.key.compareTo(e2.key)));
      // } else
      //   sortedMyGroceryList = {};
      final Map<String, dynamic> sortedMyGroceryList =
          myconst.shortedMyGroceryList(myGroceryList: myGroceryList);
      return DisplayNestedListView(
          myGroceryList: sortedMyGroceryList, onBuyPage: true);
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

  bool _displayOnBuyPage(List<Catagory> items) {
    bool showItemOnPage = false;
    for (int i = 0; i < items.length; i++) {
      if (items[i].toBuy) print('################${items[i].toBuy}');
      return showItemOnPage = true;
    }
    return showItemOnPage;
  }

  bool _displayOnBoughtPage(List<Catagory> items) {
    bool showItemOnPage = false;
    for (int i = 0; i < items.length; i++) {
      if (!items[i].toBuy) return showItemOnPage = true;
    }
    return showItemOnPage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: myGroceryList.length,
              itemBuilder: (BuildContext context, int index) {
                final String? catagoryTitle =
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
                        Text(
                          catagoryTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      if ((itemsListLen == 0) ||
                          (_displayOnBuyPage(catagoryItems as List<Catagory>) ==
                                  true &&
                              onBuyPage) ||
                          (_displayOnBoughtPage(
                                      catagoryItems as List<Catagory>) ==
                                  true &&
                              !onBuyPage))
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

                                log.i('ItemName $itemName & toBuy $toBuy');

                                if (onBuyPage && toBuy) {
                                  return ItemCardListTile(
                                    name: itemName,
                                    tobuy: toBuy,
                                  );
                                } else if (!onBuyPage && !toBuy) {
                                  log.i('toBuy $toBuy');
                                  return ItemCardListTile(
                                    name: itemName,
                                    tobuy: toBuy,
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

class ItemListView extends StatefulWidget {
  final String catagoryName;
  final List<dynamic> itemListMap;
  const ItemListView({
    Key? key,
    required this.catagoryName,
    required this.itemListMap,
  }) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final log = logger(ItemListView);

  @override
  Widget build(BuildContext context) {
    // final itemListMap = itemList.map((_list) => _list.toJson()).toList();
    final user = Provider.of<UserModel?>(context);
    final String userId = user?.uid ?? '';
    log.d(widget.itemListMap);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.itemListMap.length,
      itemBuilder: (BuildContext context, index) {
        bool undoAction = true;

        return Dismissible(
            key: UniqueKey(),
            confirmDismiss: (DismissDirection dismissDirection) async {
              // https://flutter.dev/docs/cookbook/design/snackbars
              // https://stackoverflow.com/questions/64135284/how-to-achieve-delete-and-undo-operations-on-dismissible-widget-in-flutter
              if (dismissDirection == DismissDirection.startToEnd) {
                myconst.simpleSnackBar(
                    context: context,
                    displayMsg: '1 item moved to bought',
                    onPressed: () {
                      undoAction = false;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      setState(() {});
                    });
                log.i('${widget.itemListMap[index][kName]} moved to bought');

                return true;
              } else {
                myconst.simpleSnackBar(
                    context: context,
                    displayMsg: '1 item moved to trash',
                    onPressed: () {
                      undoAction = false;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      setState(() {});
                    });
                log.i('${widget.itemListMap[index][kName]} moved to trash');
                return true;
              }
            },
            background: myconst.dismissibleBackground(
                mainAxisAlignment: MainAxisAlignment.start,
                msgText: 'Move to Bought'),
            secondaryBackground: myconst.secondaryBackground(
                mainAxisAlignment: MainAxisAlignment.end),
            onDismissed: (DismissDirection direction) async {
              // added delay to get updated value of undoAction
              await Future.delayed(const Duration(seconds: 5));

              if (direction == DismissDirection.startToEnd) {
                if (undoAction) {
                  widget.itemListMap[index][kToBuy] = false;

                  await DatabaseService(uid: userId).moveToBuyBought(
                    catagoryName: widget.catagoryName,
                    mapList: widget.itemListMap,
                  );
                }
              } else {
                if (undoAction) {
                  await DatabaseService(uid: userId).deleteItemFromCataogry(
                    catagoryName: widget.catagoryName,
                    mapList: widget.itemListMap[index],
                  );
                }
              }
            },
            child: ItemCardListTile(
                tobuy: widget.itemListMap[index][kToBuy] as bool,
                name: widget.itemListMap[index][kName].toString()));
      },
    );
  }
}
