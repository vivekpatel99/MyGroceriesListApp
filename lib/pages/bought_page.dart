import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:provider/provider.dart';

class BoughtPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final dairyProdList = CatagoryItemModel.dairyProdList;
  final vegetablesList = CatagoryItemModel.vegetablesList;
  final fruitsList = CatagoryItemModel.fruitsList;
  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<List<MyGroceryList>>(context);
      print(myGroceryList[0].dairyList![0].toBuy);
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[0],
                  itemList: myGroceryList[0].dairyList),
              const Divider(),
              _CatagorySectionBoughtpage(
                  catagory: _catagoryList[1],
                  itemList: myGroceryList[0].vegetableList),
              const Divider(),
              _CatagorySectionBoughtpage(
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

class _CatagorySectionBoughtpage extends StatelessWidget {
  _CatagorySectionBoughtpage({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<dynamic>? itemList;
  final CatagoryItemModel cTM = CatagoryItemModel();
  @override
  Widget build(BuildContext context) {
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
          if (itemList!.isEmpty)
            const Text("No Items")
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemList!.length,
              itemBuilder: (BuildContext context, index) {
                final String _name = itemList![index].name as String;
                bool _toBuy = itemList![index].toBuy as bool;
                return Dismissible(
                  key: UniqueKey(),
                  // direction: DismissDirection.endToStart,
                  background: secondaryBackground(
                      mainAxisAlignment: MainAxisAlignment.start),
                  secondaryBackground: dismissibleBackground(
                      mainAxisAlignment: MainAxisAlignment.end,
                      msgText: 'Move to Buy'),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      _toBuy = true;
                    } else {
                      // cTM.remove(listName: itemList, index: index);
                    }
                  },
                  child: Card(
                    child: !_toBuy
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
