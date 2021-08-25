import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/pages/page_constants/page_constants.dart'
    as myconst;
import 'package:my_grocery_list/pages/total_price/total_price_viewmodel.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/list_tile_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

//TODO REFACTOR CODE
//--------------------------------------------------------------------------------------------
class ItemCardListTile extends StatelessWidget {
  final bool onBuyPage;
  final String catagoryTitle;
  final bool tobuy;
  final String itemName;
  final String quantity;
  final num price;

  ItemCardListTile({
    Key? key,
    required this.onBuyPage,
    required this.catagoryTitle,
    required this.tobuy,
    required this.itemName,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  static const String assetsPath = 'assets/images/';
  static const String imageExt = '.png';
  final log = getLogger('ItemCardListTile');
  final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();
  //------------------------------------------------------------------------------
  Future<AssetImage?> checkImageExist(String imagePath) async {
    try {
      await rootBundle.load(imagePath);
      return AssetImage(imagePath);
    } catch (e) {
      log.e(e.toString());
      return null;
    }
  }

  //-------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final String firstLettter = itemName[0];

    final Map<String, dynamic> myGroceryList =
        catagoryItemsViewModel.myGroceryList ?? {};
    final String imagePath =
        '${ItemCardListTile.assetsPath}${itemName.toLowerCase()}${ItemCardListTile.imageExt}';
    // final String imagePath = 'assets/images/broccoli.png';

    //------------------------------------------------------------------------------
    Future<bool?> _onDismissedForBoughtPage(
        {required DismissDirection dismissDirection,
        required TotalPriceViewModel model,
        required CatagoryItemsViewModel catagoryItemsViewModel,
        required List<dynamic> catagoryItemList}) async {
      // https://flutter.dev/docs/cookbook/design/snackbars
      // https://stackoverflow.com/questions/64135284/how-to-achieve-delete-and-undo-operations-on-dismissible-widget-in-flutter
      if (dismissDirection == DismissDirection.endToStart) {
        log.i('$itemName move to buy');

        final Catagory _catagory = Catagory(
          name: itemName,
          price: price,
          quantity: quantity,
          toBuy: true,
        );

        catagoryItemsViewModel.moveToBuyBought(
            catagory: _catagory,
            catagoryItemList: catagoryItemList,
            catagoryTitle: catagoryTitle,
            itemName: itemName);
        _snackBarService.showSnackbar(message: '$itemName Item moved to buy');

        model.updateItemPrice(itemName: itemName, price: price);
      }
    }

    //------------------------------------------------------------------------------
    Future<bool?> _onDismissedForBuyPage(
        {required DismissDirection dismissDirection,
        required TotalPriceViewModel model,
        required CatagoryItemsViewModel catagoryItemsViewModel,
        required List<dynamic> catagoryItemList}) async {
      if (dismissDirection == DismissDirection.startToEnd) {
        log.i('$itemName move to bought');

        final Catagory _catagory = Catagory(
          name: itemName,
          price: price,
          quantity: quantity,
          toBuy: false,
        );

        catagoryItemsViewModel.moveToBuyBought(
            catagory: _catagory,
            catagoryItemList: catagoryItemList,
            catagoryTitle: catagoryTitle,
            itemName: itemName);
        _snackBarService.showSnackbar(
            message: '$itemName Item moved to bought');

        model.removeItemWithPrice(itemName: itemName);
      }
    }

    //------------------------------------------------------------------------------
    Future _deleteItemsFromCatagory(
        {required CatagoryItemsViewModel catagoryItemsViewModel}) async {
      final Map<String, dynamic> itemListMap = {
        kName: itemName,
        kPrice: price,
        kQuantity: quantity,
        kToBuy: tobuy
      };

      await catagoryItemsViewModel.deleteItemFromCataogry(
        catagoryName: catagoryTitle,
        mapList: itemListMap,
      );
    }

    //------------------------------------------------------------------------------
    Future<bool?> _conformDeleteShowDialog(
        {required CatagoryItemsViewModel catagoryItemsViewModel}) async {
      final _response = await _dialogService.showConfirmationDialog(
        title: 'Are you sure you want to delete $itemName?',
        barrierDismissible: true,
      );
      if (_response?.confirmed != null) {
        _deleteItemsFromCatagory(
          catagoryItemsViewModel: catagoryItemsViewModel,
        );
        return true;
      } else {
        return false;
      }
    }

    // return showDialog<bool>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Conform'),
    //       content: Text('Are you sure you want to delete $itemName?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             // setState(() {});
    //             return Navigator.of(context).pop(false);
    //           },
    //           child: const Text('Cancel'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             // * delete the item
    //             _deleteItemsFromCatagory(
    //                 catagoryItemsViewModel: catagoryItemsViewModel);
    //             // setState(() {});
    //             return Navigator.of(context).pop(true);
    //           },
    //           child: const Text(
    //             'Delete',
    //             style: TextStyle(color: Colors.red),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );

    //------------------------------------------------------------------------------
    Future<bool?> _confirmDismissForBuyPage(
        {required DismissDirection dismissDirection,
        required CatagoryItemsViewModel catagoryItemsViewModel}) async {
      if (dismissDirection == DismissDirection.endToStart) {
        log.i('$itemName moved to bought');

        return _conformDeleteShowDialog(
            catagoryItemsViewModel: catagoryItemsViewModel);
      }
      return true;
    }

    //------------------------------------------------------------------------------
    Future<bool?> _confirmDismissForBoughtPage(
        {required DismissDirection dismissDirection,
        required CatagoryItemsViewModel catagoryItemsViewModel}) async {
      if (dismissDirection == DismissDirection.startToEnd) {
        log.i('$itemName deteled');

        return _conformDeleteShowDialog(
            catagoryItemsViewModel: catagoryItemsViewModel);
      }
      return true;
    }

    //--------------------------------------------------------------------------------------
    return ViewModelBuilder<TotalPriceViewModel>.reactive(
      builder: (context, model, child) => FutureBuilder(
        future: checkImageExist(imagePath),
        builder: (BuildContext context, snapshot) {
          final _snapshotData = snapshot.data;
          return Dismissible(
            key: UniqueKey(),
            background: onBuyPage
                ? myconst.dismissibleBackground(
                    mainAxisAlignment: MainAxisAlignment.start,
                    msgText: 'Bought')
                : myconst.secondaryBackground(
                    mainAxisAlignment: MainAxisAlignment.start),
            secondaryBackground: onBuyPage
                ? myconst.secondaryBackground(
                    mainAxisAlignment: MainAxisAlignment.end)
                : myconst.dismissibleBackground(
                    mainAxisAlignment: MainAxisAlignment.end, msgText: 'Buy'),
            confirmDismiss: (DismissDirection dismissDirection) {
              return onBuyPage
                  ? _confirmDismissForBuyPage(
                      dismissDirection: dismissDirection,
                      catagoryItemsViewModel: catagoryItemsViewModel)
                  : _confirmDismissForBoughtPage(
                      dismissDirection: dismissDirection,
                      catagoryItemsViewModel: catagoryItemsViewModel);
            },
            onDismissed: (DismissDirection dismissDirection) {
              final List<dynamic> catagoryItemList =
                  myGroceryList[catagoryTitle] as List<dynamic>;
              onBuyPage
                  ? _onDismissedForBuyPage(
                      model: model,
                      catagoryItemList: catagoryItemList,
                      dismissDirection: dismissDirection,
                      catagoryItemsViewModel: catagoryItemsViewModel)
                  : _onDismissedForBoughtPage(
                      model: model,
                      catagoryItemList: catagoryItemList,
                      dismissDirection: dismissDirection,
                      catagoryItemsViewModel: catagoryItemsViewModel);
            },
            child: ListTileCard(
              snapshotData: _snapshotData,
              imagePath: imagePath,
              firstLettter: firstLettter,
              itemName: itemName,
              quantity: quantity,
              price: price,
              catagoryTitle: catagoryTitle,
            ),
          );
        },
      ),
      viewModelBuilder: () => TotalPriceViewModel(),
    );
  }
}
