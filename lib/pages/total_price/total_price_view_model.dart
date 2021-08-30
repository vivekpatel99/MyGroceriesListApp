import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';

class TotalPriceViewModelOld with ChangeNotifier {
  final Map<String, num> itemWithPriceMap = {};
  final log = getLogger('TotalPriceViewModelOld');
  num _count = 0.00;
  num get count {
    if (itemWithPriceMap.isEmpty) {
      return 0.00;
    } else {
      _count = 0.00;
      itemWithPriceMap.forEach((key, value) {
        _count += value;
      });
      log.d('_count $_count');
      return _count;
    }
  }

  void initItemPriceCount() {}
  //------------------------------------------------------------------------------
  Future addItemPrice({required String itemName, required num price}) async {
    final Map<String, num> items = {itemName: price};
    if (!itemWithPriceMap.containsKey(itemName)) {
      itemWithPriceMap.addAll(items);
      log.i('addItemPrice $items');
    }
    // _count += price;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future removeItemPrice({required String itemName}) async {
    // final Map<String, num> items = {itemName: price};

    itemWithPriceMap.remove(itemName);
    log.i('removeItemPrice $itemName');

    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future reset() async {
    _count = 0.00;
    itemWithPriceMap.clear();
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}
