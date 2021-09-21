// class TestCatagoryItemsViewModel extends CatagoryItemsViewModel {
//   TestCatagoryItemsViewModel() : super();
//   @override
//   DatabaseService get _databaseService => TestDatabaseService(uid: 'abc');
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';

import '../helpers/test_data.dart';
import '../helpers/test_helpers.dart';

CatagoryItemsViewModel _catagoryItemsViewModel() => CatagoryItemsViewModel();

void main() {
  setUp(() => registerServices());
  tearDown(() => unregisterServices());

  group('CatagoryItemViewModel -', () {
    final _service = getAndRegisterDatabaseService();
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
      // final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test(
          'When myGroceryList setter called, should set arg map to _myGroceryList',
          () {
        model.myGroceryList = tkFirebaseResponseMap;
        expect(model.myGroceryList, tkFirebaseResponseMap);
      });
    });

    // --------------------------------------------------------------------------------------

    group('ItemFoundInCatagoryItems -', () {
      // final _service = getAndRegisterDatabaseService();
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

    group('addUpdateItem -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test('When addUpdateItem called, should call addUpdateItemInCollection',
          () async {
        await model.addUpdateItem(
            catagoryName: tkCatagoryName, catagoryItemList: tkCatagoryItemList);
        verify(_service.addUpdateItemInCollection(
            catagoryName: tkCatagoryName,
            catagoryItemJson: ktCatagoryItemJson));
      });
    });
// --------------------------------------------------------------------------------------
    // group('moveToBuyBought -', () {
    //   final _service = getAndRegisterDatabaseService();
    //   final model = _catagoryItemsViewModel();
    //   test('Wehn moveToBuyBought called, should call addUpdateItem', () {
    //     model.moveToBuyBought(
    //         itemName: kItemNameMixVeg,
    //         catagoryTitle: tkCatagoryName,
    //         catagory: tkDairy,
    //         catagoryItemList: tkCatagoryItemList);

    //     verify(_service.addUpdateItemInCollection(
    //         catagoryName: tkCatagoryName,
    //         catagoryItemJson: ktCatagoryItemJson));
    //   });
    // });
    // --------------------------------------------------------------------------------------
    group('deleteItemFromCataogry -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test(
          'When deleteItemFromCataogry called, should call deleteItemFromCataogryList',
          () {
        model.deleteItemFromCataogry(
            catagoryName: tkCatagoryName, mapList: tkitemListMap);

        verify(_service.deleteItemFromCataogryList(
            catagoryName: tkCatagoryName, mapList: tkitemListMap));
      });
    });
    // --------------------------------------------------------------------------------------
    group('streamMyGroceryList -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test(
          'When streamMyGroceryList called, should call streamMyGroceryListMap',
          () {
        model.streamMyGroceryList;

        verify(_service.streamMyGroceryListMap);
      });
    });
    // --------------------------------------------------------------------------------------
    group('deleteCatagory -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test(
          'When deleteCatagory called, should call deleteCatagoryFromCollection',
          () {
        model.deleteCatagory(catagoryName: tkCatagoryName);

        verify(_service.deleteCatagoryFromCollection(
            catagoryName: tkCatagoryName));
      });
    });
    // --------------------------------------------------------------------------------------
    group('addCatagory -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test('When addCatagory called, should call addCatagoryCollection', () {
        model.addCatagory(catagoryName: tkCatagoryName);

        verify(_service.addCatagoryCollection(catagoryName: tkCatagoryName));
      });
    });
    // --------------------------------------------------------------------------------------
    group('deleteAllItems -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test(
          'When deleteAllItems called, should deletedItemFromCatagoryList addCatagory',
          () {
        model.deleteAllItems();

        verify(_service.deletedItemFromCatagoryList());
      });
    });
    // --------------------------------------------------------------------------------------
    group('initDatabaseSetup -', () {
      final _service = getAndRegisterDatabaseService();
      final model = _catagoryItemsViewModel();
      test('When initDatabaseSetup called, should updateUserData addCatagory',
          () {
        model.initDatabaseSetup();

        verify(_service.updateUserData(myGroceryList: tkmylist));
      });
    });
  });
}
