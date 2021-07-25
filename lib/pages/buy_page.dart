import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';

class BuyPage extends StatelessWidget {
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
            CatagorySection(
                catagory: _catagoryList[0], itemList: dairyProdList),
            const Divider(),
            CatagorySection(
                catagory: _catagoryList[1], itemList: vegetablesList),
            const Divider(),
            CatagorySection(catagory: _catagoryList[2], itemList: fruitsList),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class CatagorySection extends StatelessWidget {
  const CatagorySection({
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
                  key: ValueKey(itemList[index].id),
                  background: Container(
                    color: Colors.deepPurpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: const [
                          Icon(Icons.forward),
                          Text('Move to Bought')
                        ],
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.delete),
                          Text(
                            'Move to Trash',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // direction: DismissDirection.startToEnd,
                  onDismissed: (DismissDirection direction) {
                    // TODO: add undo snackbar when delete the item
                    if (direction == DismissDirection.startToEnd) {
                      itemList[index].status = false;
                    } else {
                      print('remove item');
                    }
                  },
                  child: Card(
                    child: itemList[index].status
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
