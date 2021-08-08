import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';

class ItemCardListTile extends StatelessWidget {
  final String catagoryTitle;
  final bool tobuy;
  final String itemName;
  final String quantity;
  final double price;
  ItemCardListTile({
    Key? key,
    required this.catagoryTitle,
    required this.tobuy,
    required this.itemName,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final log = logger(ItemCardListTile);

  static const String assetsPath = 'assets/images/';

  static const String imageExt = '.png';

  @override
  Widget build(BuildContext context) {
    final String firstLettter = itemName[0];

    final String imagePath = '$assetsPath${itemName.toLowerCase()}$imageExt';
    // final String imagePath = 'assets/images/broccoli.png';

    Future<AssetImage?> checkImageExist(String imagePath) async {
      try {
        await rootBundle.load(imagePath);
        return AssetImage(imagePath);
      } catch (e) {
        log.e(e.toString());
        return null;
      }
    }

    return FutureBuilder(
      future: checkImageExist(imagePath),
      builder: (BuildContext context, snapshot) {
        final _data = snapshot.data;
        return Dismissible(
            key: UniqueKey(),
            child: ListTileCard(
                data: _data,
                imagePath: imagePath,
                firstLettter: firstLettter,
                itemName: itemName,
                quantity: quantity,
                price: price,
                catagoryTitle: catagoryTitle));
      },
    );
  }
}

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    Key? key,
    required Object? data,
    required this.imagePath,
    required this.firstLettter,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.catagoryTitle,
  })  : _data = data,
        super(key: key);

  final Object? _data;
  final String imagePath;
  final String firstLettter;
  final String itemName;
  final String quantity;
  final double price;
  final String catagoryTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Card(
          child: ListTile(
              // dense: true,
              leading: CircleAvatar(
                foregroundImage: (_data != null) ? AssetImage(imagePath) : null,
                child: (_data != null) ? null : Text(firstLettter),
              ),
              title: Text(
                itemName,
                style: const TextStyle(fontSize: 14.0),
              ),
              subtitle: Text(
                quantity,
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
                            );
                          });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ))),
    );
  }
}
