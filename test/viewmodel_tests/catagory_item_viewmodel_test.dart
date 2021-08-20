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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  final TestCatagoryItemsViewModel catagoryItemsViewModel =
      TestCatagoryItemsViewModel();
  group('CatagoryItemViewModel -', () {
    group('ItemFoundInCatagoryItems -', () {
      test('If item Found then return index as int', () {
        final int result = catagoryItemsViewModel.itemFoundInCatagoryItems(
            catagoryItems: tkCatagoryItems, itemName: 'milk');
        expect(result, 0);
      });
      test('If item can not Found then return -1', () {
        final int result = catagoryItemsViewModel.itemFoundInCatagoryItems(
            catagoryItems: tkCatagoryItems, itemName: 'Pen');
        expect(result, -1);
      });
    });
  });

  // group('addUpdateItem -', () {
  //   test('Add data into Firebase Cloud', () async {
  //     final List<Catagory> catagoryItemList = [tkDairy];
  //     final result = await catagoryItemsViewModel.addUpdateItem(
  //         catagoryName: tkCatagoryName, catagoryItemList: catagoryItemList);
  //     expect(result, 'Success');
  //   });
  // });
}
