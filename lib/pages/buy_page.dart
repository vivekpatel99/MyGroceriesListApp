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
            Divider(),
            CatagorySection(
                catagory: _catagoryList[1], itemList: vegetablesList),
            Divider(),
            CatagorySection(catagory: _catagoryList[2], itemList: fruitsList),
            Divider(),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            catagory.catagoryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          itemList.isEmpty
              ? Text("No Items")
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (_) {
                        itemList[index].status = false;
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
