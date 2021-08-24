import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/services/total_price_service.dart';
import 'package:stacked/stacked.dart';

class TotalPriceViewModel extends ReactiveViewModel {
  final _totalPriceService = locator<TotalPriceService>();
  final Map<String, num> itemWithPriceMap = {};
  final log = getLogger('TotalPriceViewModel');

  num get count => _totalPriceService.count;

  //------------------------------------------------------------------------------
  void initItemPriceCount() {}

  //------------------------------------------------------------------------------
  Future addItemsPrice({required String itemName, required num price}) async {
    log.i('addItemsPrice $itemName $price');
    _totalPriceService.addItemPrice(itemName: itemName, price: price);
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future removeItemsPrice({required String itemName}) async {
    // final Map<String, num> items = {itemName: price};

    // itemWithPriceMap.remove(itemName);
    _totalPriceService.removeItemPrice(itemName: itemName);
    log.i('removeItemPrice $itemName');

    // await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future resetPriceToZero() async {
    // _count = 0.00;
    // itemWithPriceMap.clear();
    _totalPriceService.reset();
    // await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  void updateItemPrice({required String itemName, required num price}) {
    print('################ updateItemPrice');
    log.i('updateItemPrice $itemName  $price');
    _totalPriceService.addItemPrice(itemName: itemName, price: price);
    notifyListeners();
  }

//------------------------------------------------------------------------------
  void removeItemWithPrice({required String itemName}) {
    log.i('removeItemWithPrice $itemName ');
    _totalPriceService.removeItemPrice(itemName: itemName);
    notifyListeners();
  }

  //------------------------------------------------------------------------------
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_totalPriceService];
}
