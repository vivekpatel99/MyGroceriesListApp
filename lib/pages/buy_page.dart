import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:provider/provider.dart';

//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;

  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<MyGroceryList>(context);
      final myplist = myGroceryList.toJson();
      print('BBBBBUUUUUUUYYYYYY');
      print(myplist);

      return Scaffold(
        // Todo: replace in SingleChildScrollView with ListWheelScrollView
        body: SingleChildScrollView(
          child: Column(
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
    } catch (e) {
      print(e.toString());
      return const Loading();
    }
  }
}

class CatagorySection extends StatelessWidget {
  const CatagorySection({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;

  @override
  Widget build(BuildContext context) {
    final _itemList = itemList ?? [];

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
          else
            ItemListView(
              catagoryName: catagory.catagoryName,
              itemList: _itemList,
            ),
        ],
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  final String catagoryName;
  final List<dynamic> itemList;
  const ItemListView({
    Key? key,
    required this.catagoryName,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemListMap = itemList.map((_list) => _list.toJson()).toList();
    final user = Provider.of<UserModel?>(context);
    final String userId = user?.uid ?? '';
    print(itemListMap);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemList.length,
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
              itemListMap[index]['toBuy'] = false;
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
            child: itemListMap[index]['toBuy'] as bool
                ? ListTile(
                    title: Text(itemList[index].name.toString()),
                  )
                : null,
          ),
        );
      },
    );
  }
}
