import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart';

class BoughtPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final dairyProdList = CatagoryItemModel.dairyProdList;
  final vegetablesList = CatagoryItemModel.vegetablesList;
  final fruitsList = CatagoryItemModel.fruitsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CatagorySectionBoughtpage(
                catagory: _catagoryList[0], itemList: dairyProdList),
            const Divider(),
            _CatagorySectionBoughtpage(
                catagory: _catagoryList[1], itemList: vegetablesList),
            const Divider(),
            _CatagorySectionBoughtpage(
                catagory: _catagoryList[2], itemList: fruitsList),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _CatagorySectionBoughtpage extends StatelessWidget {
  const _CatagorySectionBoughtpage({
    Key? key,
    required this.catagory,
    required this.itemList,
  }) : super(key: key);

  final CatagoryItem catagory;
  final List<ItemModel> itemList;

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
          if (itemList.isEmpty)
            const Text("No Items")
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  // direction: DismissDirection.endToStart,
                  background: secondaryBackground(
                      mainAxisAlignment: MainAxisAlignment.start),
                  secondaryBackground: dismissibleBackground(
                      mainAxisAlignment: MainAxisAlignment.end,
                      msgText: 'Move to Buy'),
                  onDismissed: (_) {
                    itemList[index].status = true;
                  },
                  child: Card(
                    child: !itemList[index].status
                        ? ListTile(
                            title: Text(itemList[index].name),
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
