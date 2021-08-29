import 'package:flutter/scheduler.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:stacked/stacked.dart';

class PopupAddItemViewModel extends FormViewModel {
  final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();

  final log = getLogger('PopupAddItemViewModel');
  String _itemName = '';
  String _quantity = '';
  String _price = '0.0';
  @override
  void setFormStatus() {}

  VoidCallback? getUserItemName(String value) {
    _itemName = value;
  }

  VoidCallback? getItemQuantity(String value) {
    _quantity = value;
  }

  VoidCallback? getItemPrice(String value) {
    _price = value;
  }

  num string2num({required String? stringNum}) {
    try {
      return num.tryParse(stringNum ?? '') ?? 0.0;
    } on Exception catch (_) {
      return 0.0;
    }
  }

  int getKeyIndexFromList(
      {required List<dynamic> myList, required String listKey}) {
    return myList.indexWhere((element) => element.name == listKey);
  }

  List<dynamic> prepareMyGroceryList({required String catagoryName}) {
    final Map<String, dynamic> myGroceryList =
        catagoryItemsViewModel.myGroceryList ?? {};
    final List<dynamic> itemList =
        (myGroceryList[catagoryName] ?? []) as List<dynamic>;

    return itemList
        .map<Catagory>(
            (json) => Catagory.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  void updateUserInputs(
      {required String itemName,
      required String catagoryName,
      required String quantity,
      required num price,
      required bool onBuyPage,
      required bool addUpdate}) async {
    /// arquments are old values
    log.i('updateUserInputs');

    // catagoryItems.indexWhere((element) => element.name == itemName);

    //                       _price = _priceTextFieldController.text.isEmpty
//                           ? _price = 0.0
//                           : _price;

//                       _quantity = _quantityTextFieldController.text == '' ||
//                               _quantityTextFieldController.text.isEmpty
//                           ? _quantity = ''
//                           : _quantity;

//                       _addItemButtonVerification(context);

//                       if (_itemName.isNotEmpty ||
//                           _price != 0.0 ||
//                           _quantity.isNotEmpty) {
//                         final Catagory _catagory = Catagory(
//                           name: _itemName.isNotEmpty &&
//                                   widget.itemName != _itemName
//                               ? _itemName
//                               : widget.itemName,
//                           price: _price != 0.0 && widget.price != _price
//                               ? _price
//                               : 0.00,
//                           quantity: _quantity.isNotEmpty &&
//                                   widget.quantity != _quantity
//                               ? _quantity
//                               : widget.quantity,
//                           toBuy: widget.onBuyPage,
//                         );

//                         if (foundItemIndex != -1) {
//                           catagoryItems[foundItemIndex] = _catagory;
//                           log.i(
//                               'foundItemIndex: $foundItemIndex, catagoryName: ${widget.catagoryName}, ItemName: $_itemName, Quantity: $_quantity, price €$_price');
//                         } else {
//                           catagoryItems.add(_catagory);
//                           log.i(
//                               'New index added for ItemName: $_itemName, Quantity: $_quantity, price €$_price');
//                         }
//                         await catagoryItemsViewModel.addUpdateItem(
//                           catagoryName: widget.catagoryName,
//                           catagoryItemList: catagoryItems,
//                         );
//                       }

    final num _userPrice = string2num(stringNum: _price);

    // Check if item name is updated? yes then delete catagory and re-create new catagory with
    // updated name and data

    if (!addUpdate) {
      if ((_itemName.isNotEmpty && _itemName != itemName) ||
          (_quantity.isNotEmpty && _quantity != quantity) ||
          (_price != '0.0' && _price != price.toString())) {
        final Catagory _catagory = Catagory(
          name: _itemName.isNotEmpty ? _itemName : itemName,
          price: _userPrice != 0.0 ? _userPrice : 0.0,
          quantity: quantity.isEmpty ? _quantity : quantity,
          toBuy: onBuyPage,
        );

        final List<dynamic> catagoryItems =
            prepareMyGroceryList(catagoryName: catagoryName);

        final int _foundItemIndex =
            getKeyIndexFromList(myList: catagoryItems, listKey: itemName);

        if (_foundItemIndex != -1) {
          catagoryItems[_foundItemIndex] = _catagory;
          log.i(
              'catagoryName $catagoryName - _catagoryName ${_catagory.name} -  Quantity ${_catagory.quantity} - Price ${_catagory.price} - toBuy ${_catagory.toBuy}');
        }
        await catagoryItemsViewModel.addUpdateItem(
            catagoryName: catagoryName,
            catagoryItemList: catagoryItems as List<Catagory>);

        // log.i(
        //     'catagoryName $catagoryName - _catagoryName ${_oldcatagory.name} -  Quantity ${_oldcatagory.quantity} - Price ${_oldcatagory.price} - toBuy ${_oldcatagory.toBuy}');

        // await catagoryItemsViewModel.addUpdateItem(catagoryItemList: );

        // final Catagory catagory = Catagory(
        //   name: itemName,
        //   price: userPrice != 0.0 ? userPrice : 0.0,
        //   quantity: quantity.isEmpty ? _quantity : quantity,
        //   toBuy: onBuyPage,
        // );

        // await catagoryItemsViewModel.addCatagory(
        //   catagoryName: catagoryName,
        // );

        // log.i(
        //     'catagoryName $catagoryName - _catagoryName ${_catagory.name} -  Quantity ${_catagory.quantity} - Price ${_catagory.price} - toBuy ${_catagory.toBuy}');
      }
    } else if (_itemName.isNotEmpty) {
      final Catagory _catagory = Catagory(
        name: _itemName,
        price: _userPrice,
        quantity: _quantity,
        toBuy: onBuyPage,
      );
      log.i(
          'New index added for ItemName: $_itemName, Quantity: $_quantity, price €$_price');
      final List<dynamic> catagoryItems =
          prepareMyGroceryList(catagoryName: catagoryName);
      catagoryItems.add(_catagory);
      await catagoryItemsViewModel.addUpdateItem(
          catagoryName: catagoryName,
          catagoryItemList: catagoryItems as List<Catagory>);
    } else {
      setValidationMessage('Item Name can not be Empty');
    }
  }
}
