import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    Key? key,
    required Object? snapshotData,
    required this.imagePath,
    required this.firstLettter,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.catagoryTitle,
  })  : _data = snapshotData,
        super(key: key);

  final Object? _data;
  final String imagePath;
  final String firstLettter;
  final String itemName;
  final String quantity;
  final num price;
  final String catagoryTitle;

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic>? _myGroceryList =
    //     Provider.of<Map<String, dynamic>?>(context);
    final _catagoryItemsService = locator<CatagoryItemsViewModel>();
    final Map<String, dynamic> myGroceryList =
        _catagoryItemsService.myGroceryList ?? {};

    return SizedBox(
      height: 70,
      child: Card(
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            foregroundImage: (_data != null) ? AssetImage(imagePath) : null,
            child: (_data != null) ? null : Text(firstLettter),
          ),
          title: Text(
            itemName,
            style: const TextStyle(fontSize: 14.0),
          ),
          subtitle: Text(
            quantity.isNotEmpty ? quantity : 'Quantity',
            style: const TextStyle(fontSize: 12.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(price.toString()),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                // color: Colors.deepPurpleAccent,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUPAddItemWindow(
                          onBuyPage: true,
                          catagoryName: catagoryTitle,
                          itemName: itemName,
                          quantity: quantity,
                          price: price,
                          myGroceryList: myGroceryList,
                        );
                      });
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
