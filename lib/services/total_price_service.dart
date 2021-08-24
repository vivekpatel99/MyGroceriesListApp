import 'package:my_grocery_list/app/app.logger.dart';
import 'package:stacked/stacked.dart';

//-------------------------------------------------------------------------------------------

class TotalPriceService with ReactiveServiceMixin {
  final log = getLogger('TotalPriceService');
  TotalPriceService() {
    listenToReactiveValues([
      _count,
      _itemWithPriceMap,
    ]);
  }
  final ReactiveValue<Map<String, num>> _itemWithPriceMap =
      ReactiveValue<Map<String, num>>({});
  // final Map<String, num> itemWithPriceMap = {};
  final ReactiveValue<num> _count = ReactiveValue<num>(0);
  // ReactiveValue<int> _postCount = ReactiveValue<int>(initial: 0);

  // num _count = 0.00;

  //------------------------------------------------------------------------------
  num get count {
    if (_itemWithPriceMap.value.isEmpty) {
      return 0.00;
    } else {
      _count.value = 0.00;
      _itemWithPriceMap.value.forEach((key, value) {
        _count.value += value;
      });
      log.d('_count.value ${_count.value}');
      return _count.value;
    }
  }

  //------------------------------------------------------------------------------
  void initItemPriceCount() {}
  //------------------------------------------------------------------------------
  Future addItemPrice({required String itemName, required num price}) async {
    final Map<String, num> items = {itemName: price};
    if (!_itemWithPriceMap.value.containsKey(itemName)) {
      _itemWithPriceMap.value.addAll({itemName: price});
      log.i('addItemPrice $items');
    }
    // _count += price;
    // await Future.delayed(const Duration(milliseconds: 1));
    // notifyListeners();
  }

//------------------------------------------------------------------------------
  Future removeItemPrice({required String itemName}) async {
    // final Map<String, num> items = {itemName: price};

    _itemWithPriceMap.value.remove(itemName);
    log.i('removeItemPrice $itemName');

    // await Future.delayed(const Duration(milliseconds: 1));
    // notifyListeners();
  }

//------------------------------------------------------------------------------
  Future reset() async {
    _count.value = 0.00;
    _itemWithPriceMap.value.clear();
    // await Future.delayed(const Duration(milliseconds: 1));
    // notifyListeners();
  }
}
