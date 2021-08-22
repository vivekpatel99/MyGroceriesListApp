import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/services/total_price_service.dart';
import 'package:stacked/stacked.dart';

class ItemListViewModel extends ReactiveViewModel {
  final _totalPriceService = locator<TotalPriceService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_totalPriceService];

  void updateItemPrice({required String itemName, required num price}) {
    _totalPriceService.addItemPrice(itemName: itemName, price: price);
  }

  void removeItemWithPrice({required String itemName}) {
    _totalPriceService.removeItemPrice(itemName: itemName);
  }
}
