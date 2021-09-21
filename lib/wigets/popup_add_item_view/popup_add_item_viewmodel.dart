import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/popup_add_item_view/popup_add_item_view.form.dart';
import 'package:stacked/stacked.dart';

class PopupAddItemViewModel extends FormViewModel {
  final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();

  final log = getLogger('PopupAddItemViewModel');

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

    print(
        'itemnameValue ${itemnameValue} priceValue${priceValue}  quantityValue${quantityValue}');

    final num _priceValue = string2num(stringNum: priceValue);
    final String _itemnameValue = itemnameValue ?? '';
    final String _quantityValue = quantityValue ?? '1';
    if (!addUpdate) {
      // update Item,  Item info updated
      // TODO optimized user input checks, now it failed one user remove quantity values
      if (_itemnameValue.isNotEmpty ||
          _quantityValue.isNotEmpty ||
          _priceValue != 0.0) {
        final Catagory _catagory = Catagory(
          name: _itemnameValue.isNotEmpty ? _itemnameValue : itemName,
          quantity:
              _quantityValue != '1' && quantity.isEmpty ? _quantityValue : '1',
          price: _priceValue != 0.0 ? _priceValue : price,
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
        // await catagoryItemsViewModel.addUpdateItem(
        //     catagoryName: catagoryName,
        //     catagoryItemList: catagoryItems as List<Catagory>);
      }
    }
    // New Item add
    else if (_itemnameValue.isNotEmpty) {
      final Catagory _catagory = Catagory(
        name: _itemnameValue,
        price: _priceValue,
        quantity: _quantityValue,
        toBuy: onBuyPage,
      );
      log.i(
          'New index added for ItemName: $_itemnameValue, Quantity: $_quantityValue, price €$_priceValue');
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

  @override
  void setFormStatus() {}
}
