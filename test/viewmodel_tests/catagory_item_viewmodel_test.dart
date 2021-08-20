import 'package:flutter_test/flutter_test.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';

import '../services_tests/database_test.dart';
import '../setup/test_data.dart';

class TestCatagoryItemsViewModel extends CatagoryItemsViewModel {
  TestCatagoryItemsViewModel() : super();
  @override
  DatabaseService get _databaseService => TestDatabaseService(uid: 'abc');
}

void main() {
  final TestCatagoryItemsViewModel catagoryItemsViewModel =
      TestCatagoryItemsViewModel();
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

  group('addUpdateItem -', () {
    test('Add', () {});
  });
}
