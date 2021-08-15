import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart'
    as myconst;
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';
import 'package:provider/provider.dart';

class ItemCardListTile extends StatefulWidget {
  final bool onBuyPage;
  final String catagoryTitle;
  final bool tobuy;
  final String itemName;
  final String quantity;
  final num price;
  const ItemCardListTile({
    Key? key,
    required this.onBuyPage,
    required this.catagoryTitle,
    required this.tobuy,
    required this.itemName,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  static const String assetsPath = 'assets/images/';

  static const String imageExt = '.png';

  @override
  _ItemCardListTileState createState() => _ItemCardListTileState();
}

class _ItemCardListTileState extends State<ItemCardListTile> {
  final log = logger(ItemCardListTile);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final String userId = user?.uid ?? '';
    final String firstLettter = widget.itemName[0];

    final String imagePath =
        '${ItemCardListTile.assetsPath}${widget.itemName.toLowerCase()}${ItemCardListTile.imageExt}';
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
        final _snapshotData = snapshot.data;
        return Dismissible(
          key: UniqueKey(),
          background: widget.onBuyPage
              ? myconst.dismissibleBackground(
                  mainAxisAlignment: MainAxisAlignment.start, msgText: 'Bought')
              : myconst.secondaryBackground(
                  mainAxisAlignment: MainAxisAlignment.start),
          secondaryBackground: widget.onBuyPage
              ? myconst.secondaryBackground(
                  mainAxisAlignment: MainAxisAlignment.end)
              : myconst.dismissibleBackground(
                  mainAxisAlignment: MainAxisAlignment.end, msgText: 'Buy'),
          confirmDismiss: (DismissDirection dismissDirection) {
            return widget.onBuyPage
                ? _confirmDismissForBuyPage(
                    dismissDirection: dismissDirection, uid: userId)
                : _confirmDismissForBoughtPage(
                    dismissDirection: dismissDirection, uid: userId);
          },
          onDismissed: (DismissDirection dismissDirection) {
            widget.onBuyPage
                ? _onDismissedForBuyPage(
                    dismissDirection: dismissDirection, uid: userId)
                : _onDismissedForBoughtPage(
                    dismissDirection: dismissDirection, uid: userId);
          },
          child: ListTileCard(
            snapshotData: _snapshotData,
            imagePath: imagePath,
            firstLettter: firstLettter,
            itemName: widget.itemName,
            quantity: widget.quantity,
            price: widget.price,
            catagoryTitle: widget.catagoryTitle,
          ),
        );
      },
    );
  }

  Future<bool?> _confirmDismissForBuyPage(
      {required DismissDirection dismissDirection, required String uid}) async {
    if (dismissDirection == DismissDirection.endToStart) {
      log.i('${widget.itemName} moved to bought');

      return _conformDeleteShowDialog(uid: uid);
    }
    return true;
  }

  Future<bool?> _onDismissedForBuyPage(
      {required DismissDirection dismissDirection, required String uid}) async {
    if (dismissDirection == DismissDirection.startToEnd) {
      log.i('${widget.itemName} move to bought');

      final Map<String, dynamic> _itemListMap = {
        kName: widget.itemName,
        kPrice: widget.price,
        kQuantity: widget.quantity,
        kToBuy: false
      };

      setState(() async {
        await DatabaseService(uid: uid).moveToBuyBought(
          catagoryName: widget.catagoryTitle,
          mapList: [_itemListMap],
        );
      });

      final SnackBar _snackBar = SnackBar(
        content: Text('${widget.itemName} moved to bought'),
      );
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  Future<bool?> _confirmDismissForBoughtPage(
      {required DismissDirection dismissDirection, required String uid}) async {
    if (dismissDirection == DismissDirection.startToEnd) {
      log.i('${widget.itemName} deteled');

      return _conformDeleteShowDialog(uid: uid);
    }
    return true;
  }

  Future<bool?> _onDismissedForBoughtPage(
      {required DismissDirection dismissDirection, required String uid}) async {
    // https://flutter.dev/docs/cookbook/design/snackbars
    // https://stackoverflow.com/questions/64135284/how-to-achieve-delete-and-undo-operations-on-dismissible-widget-in-flutter
    if (dismissDirection == DismissDirection.endToStart) {
      log.i('${widget.itemName} move to buy');

      final Map<String, dynamic> itemListMap = {
        kName: widget.itemName,
        kPrice: widget.price,
        kQuantity: widget.quantity,
        kToBuy: true
      };

      setState(() async {
        await DatabaseService(uid: uid).moveToBuyBought(
          catagoryName: widget.catagoryTitle,
          mapList: [itemListMap],
        );
      });

      final SnackBar _snackBar = SnackBar(
        content: Text('${widget.itemName} Item moved to buy'),
      );

      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  Future<bool?> _conformDeleteShowDialog({required String uid}) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conform'),
          content: Text('Are you sure you want to delete ${widget.itemName}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {});
                return Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // * delete the item
                _deleteItemsFromCatagory(uid: uid);
                setState(() {});
                return Navigator.of(context).pop(true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future _deleteItemsFromCatagory({required String uid}) async {
    final Map<String, dynamic> itemListMap = {
      kName: widget.itemName,
      kPrice: widget.price,
      kQuantity: widget.quantity,
      kToBuy: widget.tobuy
    };

    await DatabaseService(uid: uid).deleteItemFromCataogry(
      catagoryName: widget.catagoryTitle,
      mapList: itemListMap,
    );
  }
}

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
    final Map<String, dynamic>? _myGroceryList =
        Provider.of<Map<String, dynamic>?>(context);
    final Map<String, dynamic> myGroceryList = _myGroceryList ?? {};

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
