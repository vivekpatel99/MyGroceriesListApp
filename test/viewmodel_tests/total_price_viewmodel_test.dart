import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_grocery_list/pages/total_price/total_price_viewmodel.dart';

import '../helpers/test_data.dart';
import '../helpers/test_helpers.dart';

TotalPriceViewModel _totalPriceViewModel() => TotalPriceViewModel();
void main() {
  setUp(() => registerServices());
  tearDown(() => unregisterServices());
  group('TotalPriceViewModelTest -', () {
    final _service = getAndRegisterTotalPriceService();
    final model = _totalPriceViewModel();
    test('When called with count, should call TotalPriceService.count', () {
      model.count;
      verify(_service.count);
    });
    test('When addItemsPrice is called, should call addItemPrice()', () {
      final _service = getAndRegisterTotalPriceService();
      final model = _totalPriceViewModel();
      model.addItemsPrice(itemName: kItemNameMixVeg, price: 2);
      verify(_service.addItemPrice(itemName: kItemNameMixVeg, price: 2));
    });

    test('when removeItemPrice called, should call removeItemPrice()', () {
      final _service = getAndRegisterTotalPriceService();
      final model = _totalPriceViewModel();
      model.removeItemsPrice(itemName: kItemNameMilk);
      verify(_service.removeItemPrice(itemName: kItemNameMilk));
    });

    test('when resetPriceToZero called, should call reset()', () {
      final _service = getAndRegisterTotalPriceService();
      final model = _totalPriceViewModel();
      model.resetPriceToZero();

      verify(_service.reset());
    });

    test('when updateItemPrice called, should call addItemPrice()', () {
      final _service = getAndRegisterTotalPriceService();
      final model = _totalPriceViewModel();
      model.updateItemPrice(itemName: kItemNameMilk, price: 0);

      verify(_service.addItemPrice(itemName: kItemNameMilk, price: 0));
    });

    test('when removeItemWithPrice called, should call removeItemPrice()', () {
      final _service = getAndRegisterTotalPriceService();
      final model = _totalPriceViewModel();
      model.removeItemWithPrice(itemName: kItemNameMilk);

      verify(_service.removeItemPrice(itemName: kItemNameMilk));
    });
  });
}
