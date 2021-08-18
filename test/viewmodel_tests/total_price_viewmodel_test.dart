import 'package:flutter_test/flutter_test.dart';
import 'package:my_grocery_list/viewmodels/total_price_view_model.dart';

void main() {
  final TotalPriceViewModel totalPriceViewModel = TotalPriceViewModel();
  const String itemNameMixVeg = 'mixVeg';
  const String itemNameMilk = 'Milk';

  group('TotalPriceViewModelTest -', () {
    test('Value should start at 0.0', () {
      expect(totalPriceViewModel.count, 0.0);
    });

    group('AddItemPrice -', () {
      test('AddItemPrice should add Item and Price', () {
        totalPriceViewModel.addItemPrice(itemName: itemNameMixVeg, price: 2);
        expect(totalPriceViewModel.count, 2.0);

        totalPriceViewModel.addItemPrice(itemName: itemNameMilk, price: 0.99);
        expect(totalPriceViewModel.count, 2.99);
      });
      test('AddItemPrice if item exist then it should not add Price', () {
        totalPriceViewModel.addItemPrice(itemName: itemNameMixVeg, price: 4);
        expect(totalPriceViewModel.count, 2.99);
      });
    });

    group('removeItemPrice -', () {
      test('removeItemPrice should remove Items from list', () {
        totalPriceViewModel.removeItemPrice(itemName: itemNameMilk);
        expect(totalPriceViewModel.count, 2);
      });
    });

    test('rest should set counter back 0.0', () {
      totalPriceViewModel.reset();

      expect(totalPriceViewModel.count, 0);
    });
  });
}
