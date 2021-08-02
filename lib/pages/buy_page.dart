import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
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
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final log = logger(BuyPage);
  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<MyGroceryList>(context);
      log.d('myGroceryList : ${myGroceryList.toJson()}');

      return Scaffold(
        // Todo: replace in SingleChildScrollView with ListWheelScrollView
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatagorySection(
                  catagory: _catagoryList[0],
                  itemList: myGroceryList.dairyList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[1],
                  itemList: myGroceryList.vegetableList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[2],
                  itemList: myGroceryList.fruitsList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[3],
                  itemList: myGroceryList.breadBakeryList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[4],
                  itemList: myGroceryList.dryGoodsList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[5],
                  itemList: myGroceryList.frozenFoodsList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[6],
                  itemList: myGroceryList.beveragesList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[7],
                  itemList: myGroceryList.cleanersList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[8],
                  itemList: myGroceryList.personalCareList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[9],
                  itemList: myGroceryList.otherList),
            ],
          ),
        ),
      );
    } catch (error) {
      log.e('$error');
      log.i('returning to Loading page');
      return const Loading();
    }
  }
}

class CatagorySection extends StatelessWidget {
  CatagorySection({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;
  final log = logger(CatagorySection);
  @override
  Widget build(BuildContext context) {
    final _itemList = itemList ?? [];
    final itemListMap = _itemList.map((_list) => _list.toJson()).toList();
    log.d(itemListMap);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            catagory.catagoryName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_itemList.isEmpty)
            const Text("No Items")
          else if (!(itemListMap[0][kToBuy] as bool))
            const Text("No Items")
          else
            ItemListView(
              catagoryName: catagory.catagoryName,
              itemListMap: itemListMap,
            ),
        ],
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
                      setState(() {});
                    });
                log.i('${widget.itemListMap[index][kName]} moved to bought');
              } else {
                myconst.simpleSnackBar(
                    context: context,
                    displayMsg: '1 item moved to trash',
                    onPressed: () {
                      undoAction = false;
                      setState(() {});
                    });
                log.i('${widget.itemListMap[index][kName]} moved to trash');
              }
              return true;
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
