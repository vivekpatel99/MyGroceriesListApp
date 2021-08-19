import 'package:flutter_test/flutter_test.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';

import '../setup/test_data.dart';

void main() {
  final CatagoryItemsViewModel catagoryItemsViewModel =
      CatagoryItemsViewModel();
  group('CatagoryItemViewModel -', () {
    group('ItemFoundInCatagoryItems -', () {
      test('If item Found then return index as int', () {
        final int result = catagoryItemsViewModel.itemFoundInCatagoryItems(
            catagoryItems: catagoryItems, itemName: 'milk');
        expect(result, 0);
      });
      test('If item can not Found then return -1', () {
        final int result = catagoryItemsViewModel.itemFoundInCatagoryItems(
            catagoryItems: catagoryItems, itemName: 'Pen');
        expect(result, -1);
      });
    });
  });
}
