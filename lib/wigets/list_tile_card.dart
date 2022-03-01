import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/ui_helpers.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/dimensions.dart';
import 'package:my_grocery_list/shared/styles.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/popup_add_item_view/popup_add_item_view.dart';

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
    final _catagoryItemsService = locator<CatagoryItemsViewModel>();
    final Map<String, dynamic> myGroceryList =
        _catagoryItemsService.myGroceryList ?? {};

    return SizedBox(
      height: 70, //Dimensions.sizeBoxHeight70,
      child: Card(
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            foregroundImage: (_data != null) ? AssetImage(imagePath) : null,
            child: (_data != null) ? null : Text(firstLettter),
          ),
          title: Text(
            itemName,
            style: itemNameStyle,
          ),
          subtitle: Row(
            children: [
              Text(
                kQTY,
                style: captionStyle,
              ),
              kHorizontalSpaceSmall,
              Text(
                quantity,
                style: captionStyle,
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(price.toString()),
              SizedBox(
                width: Dimensions.sizeBoxWidth20,
              ),
              IconButton(
                // color: Colors.deepPurpleAccent,
                onPressed: () {
                  //TODO add custom dialog from stacked package
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupAddItemView(
                          addUpdate: false,
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



// Container(
//             width: 20,
//             height: 20,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                   image: _data != null
//                       ? AssetImage(imagePath)
//                       : AssetImage('assets/icon/icon.png')),
//             ),
//             child: (_data != null) ? null : Text(firstLettter),
//           )
