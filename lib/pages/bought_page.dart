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

class BoughtPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final log = logger(BoughtPage);
  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<MyGroceryList>(context);
      log.d('_catagoryList : $_catagoryList');
      log.d('myGroceryList : ${myGroceryList.toJson()}');

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[0],
                  itemList: myGroceryList.dairyList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[1],
                  itemList: myGroceryList.vegetableList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[2],
                  itemList: myGroceryList.fruitsList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[3],
                  itemList: myGroceryList.breadBakeryList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[4],
                  itemList: myGroceryList.dryGoodsList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[5],
                  itemList: myGroceryList.frozenFoodsList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[6],
                  itemList: myGroceryList.beveragesList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[7],
                  itemList: myGroceryList.cleanersList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[8],
                  itemList: myGroceryList.personalCareList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[9],
                  itemList: myGroceryList.otherList),
            ],
          ),
        ),
      );
    } catch (error) {
      log.e('$error');
      log.i('Returning to Loading page');
      return const Loading();
    }
  }
}

class _CatagorySectionBoughtpage extends StatelessWidget {
  const _CatagorySectionBoughtpage({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final log = logger(_CatagorySectionBoughtpage);

    final _itemList = itemList ?? [];
    final String userId = user?.uid ?? '';
    final itemListMap = _itemList.map((_list) => _list.toJson()).toList();
    log.d('itemListMap : $itemListMap');
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
          else if (itemListMap[0][kToBuy] as bool)
            const Text("No Items")
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _itemList.length,
              itemBuilder: (BuildContext context, index) {
                final String _name = _itemList[index].name as String;

                return Dismissible(
                  key: UniqueKey(),
                  background: secondaryBackground(
                      mainAxisAlignment: MainAxisAlignment.start),
                  secondaryBackground: dismissibleBackground(
                      mainAxisAlignment: MainAxisAlignment.end,
                      msgText: 'Move to Buy'),
                  onDismissed: (DismissDirection direction) async {
                    if (direction == DismissDirection.endToStart) {
                      itemListMap[index][kToBuy] = true;
                      await DatabaseService(uid: userId).moveToBuyBought(
                        catagoryName: catagory.catagoryName,
                        mapList: itemListMap,
                      );
                    } else {
                      await DatabaseService(uid: userId).deleteItemFromCataogry(
                        catagoryName: catagory.catagoryName,
                        mapList: itemListMap[index],
                      );
                    }
                  },
                  child: Card(
                    child: !(itemListMap[index][kToBuy] as bool)
                        ? ListTile(
                            title: Text(_name),
                          )
                        : null,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
