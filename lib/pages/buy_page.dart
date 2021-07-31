import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/utils/logging.dart';
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

class ItemListView extends StatelessWidget {
  final String catagoryName;
  final List<dynamic> itemListMap;
  ItemListView({
    Key? key,
    required this.catagoryName,
    required this.itemListMap,
  }) : super(key: key);
  final log = logger(ItemListView);
  @override
  Widget build(BuildContext context) {
    // final itemListMap = itemList.map((_list) => _list.toJson()).toList();
    final user = Provider.of<UserModel?>(context);
    final String userId = user?.uid ?? '';
    log.d(itemListMap);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemListMap.length,
      itemBuilder: (BuildContext context, index) {
        return Dismissible(
          key: UniqueKey(), //ValueKey(itemList[index].name),
          background: dismissibleBackground(
              mainAxisAlignment: MainAxisAlignment.start,
              msgText: 'Move to Bought'),
          secondaryBackground:
              secondaryBackground(mainAxisAlignment: MainAxisAlignment.end),
          onDismissed: (DismissDirection direction) async {
            // TODO: add undo snackbar when delete the item
            if (direction == DismissDirection.startToEnd) {
              itemListMap[index][kToBuy] = false;
              await DatabaseService(uid: userId).moveToBuyBought(
                catagoryName: catagoryName,
                mapList: itemListMap,
              );
            } else {
              await DatabaseService(uid: userId).deleteItemFromCataogry(
                catagoryName: catagoryName,
                mapList: itemListMap[index],
              );
            }
          },
          child: Card(
            child: itemListMap[index][kToBuy] as bool
                ? ListTile(
                    title: Text(itemListMap[index][kName].toString()),
                  )
                : null,
          ),
        );
      },
    );
  }
}
