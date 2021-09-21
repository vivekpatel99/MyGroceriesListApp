import 'package:flutter_test/flutter_test.dart';
import 'package:my_grocery_list/services/total_price_service.dart';

import '../helpers/test_data.dart';

TotalPriceService _priceService() => TotalPriceService();
void main() {
  final model = _priceService();
  group('TotalPriceServiceTest -', () {
    group('count -', () {
      test('When first time count called, should return 0.0', () {
        expect(model.count, 0.0);
      });
    });

    group('addItemPrice -', () {
      test(
          'When addItemPrice called, should return update/increase count price',
          () {
        model.addItemPrice(itemName: kItemNameMixVeg, price: 1.0);
        expect(model.count, 1.0);

        model.addItemPrice(itemName: 'stuff', price: 2.0);
        expect(model.count, 3.0);
      });
    });

    group('removeItemPrice -', () {
      test(
          'When removeItemPrice called, should return update/decrease count price',
          () {
        model.removeItemPrice(itemName: kItemNameMixVeg);
        expect(model.count, 2.0);

        model.removeItemPrice(itemName: 'stuff');
        expect(model.count, 0.0);
      });
    });

    group('reset -', () {
      test('When reset called, should return reset count to 0.0', () {
        model.addItemPrice(itemName: kItemNameMixVeg, price: 1.0);
        model.addItemPrice(itemName: 'stuff', price: 2.0);
        expect(model.count, 3.0);

        model.reset();
        expect(model.count, 0.0);
      });
    });
  });
}
