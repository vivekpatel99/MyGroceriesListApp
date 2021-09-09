// class TestCatagoryItemsViewModel extends CatagoryItemsViewModel {
//   TestCatagoryItemsViewModel() : super();
//   @override
//   DatabaseService get _databaseService => TestDatabaseService(uid: 'abc');
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';

import '../helpers/test_data.dart';
import '../helpers/test_helpers.dart';

CatagoryItemsViewModel _catagoryItemsViewModel() => CatagoryItemsViewModel();

void main() async {
  setUp(() => registerServices());
  tearDown(() => unregisterServices());
  final _service = getAndRegisterFirebaseService();
  group('CatagoryItemViewModel -', () {
    //TODO make it work
    // group('currentUserId -', () {

    //   final model = _catagoryItemsViewModel();
    //   test('when currentUserId called, shell call auth.currentUser.uid', () {
    //     model.currentUserId;
    //     verify(_service.currentUser?.uid);
    //   });
    // });
    // --------------------------------------------------------------------------------------
    group('setter and getter myGroceryList -', () {
      final model = _catagoryItemsViewModel();
      test(
          'When myGroceryList setter called, should set arg map to _myGroceryList',
          () {
        model.myGroceryList = tkFirebaseResponseMap;
        expect(model.myGroceryList, tkFirebaseResponseMap);
      });
    });
    // --------------------------------------------------------------------------------------

    // --------------------------------------------------------------------------------------

    group('ItemFoundInCatagoryItems -', () {
      final _service = getAndRegisterFirebaseService();
      final model = _catagoryItemsViewModel();
      test('If item Found then return index as int', () {
        final int result = model.itemFoundInCatagoryItems(
            catagoryItems: tkCatagoryItems, itemName: 'milk');
        expect(result, 0);
      });
      test('If item can not Found then return -1', () {
        final int result = model.itemFoundInCatagoryItems(
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
