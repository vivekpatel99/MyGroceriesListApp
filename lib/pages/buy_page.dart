import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:provider/provider.dart';

class BuyPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final dairyProdList = CatagoryItemModel.dairyProdList;
  final vegetablesList = CatagoryItemModel.vegetablesList;
  final fruitsList = CatagoryItemModel.fruitsList;

  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<List<MyGroceryList>>(context);

      return Scaffold(
        // Todo: replace in SingleChildScrollView with ListWheelScrollView
        body: SingleChildScrollView(
          child: Column(
            children: [
              CatagorySection(
                  catagory: _catagoryList[0],
                  itemList: myGroceryList[0].dairyList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[1],
                  itemList: myGroceryList[0].vegetableList),
              const Divider(),
              CatagorySection(
                  catagory: _catagoryList[2],
                  itemList: myGroceryList[0].fruitsList),
              const Divider(),
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
  CatagorySection({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;
  final CatagoryItemModel cTM = CatagoryItemModel();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final _itemList = itemList ?? [];
    final String userId = user?.uid ?? '';

    // print(itemListMap);
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
              userId: userId,
            ),
        ],
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  final String catagoryName;
  final List<dynamic> itemList;
  final String userId;
  const ItemListView({
    Key? key,
    required this.catagoryName,
    required this.itemList,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemListMap = itemList.map((_list) => _list.toJson()).toList();
    print(itemListMap);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, index) {
        //  String _name = itemList[index].name ;
        // bool _toBuy = itemList[index].toBuy ;
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
              // _toBuy = false;
              // print('_buy $_toBuy');
              print(itemListMap[index]['toBuy']);
              // itemListMap[index]['toBuy'] = false;
              await DatabaseService(uid: userId).moveToBuyBought(
                catagoryName: catagoryName,
                mapList: itemListMap,
              );
            } else {
              // cTM.remove(listName: itemList, index: index);
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
