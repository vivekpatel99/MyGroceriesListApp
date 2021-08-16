import 'package:flutter/cupertino.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/logging.dart';

class CatagoryItemsViewModel with ChangeNotifier {
  final AuthService myAuth = AuthService();
  late String? currentUserId = myAuth.auth.currentUser?.uid;

  final log = logger(CatagoryItemsViewModel);

  DatabaseService get _databaseService {
    return DatabaseService(uid: currentUserId);
  }

  int itemFoundInCatagoryItems(
      {required List<Catagory> catagoryItems, required String itemName}) {
    return catagoryItems.indexWhere((element) => element.name == itemName);
  }

  //------------------------------------------------------------------------------
  Future addUpdateItem({
    required String catagoryName,
    required List<Catagory> catagoryItemList,
  }) async {
    return _databaseService.addUpdateItemInCollection(
        catagoryName: catagoryName, catagoryItemList: catagoryItemList);
  }

  //------------------------------------------------------------------------------
  Future<void> moveToBuyBought({
    required String catagoryName,
    required Map<String, dynamic> mapList,
  }) {
    return _databaseService.moveToBuyBought(
        catagoryName: catagoryName, mapList: mapList);
  }

//------------------------------------------------------------------------------
  // * delete items
  Future<void> deleteItemFromCataogry({
    required String catagoryName,
    required Map<String, dynamic> mapList,
  }) {
    return _databaseService.deleteItemFromCataogry(
        catagoryName: catagoryName, mapList: mapList);
  }

  //------------------------------------------------------------------------------
  // * get stream of grocerylist
  Stream<Map<String, dynamic>?> get streamMyGroceryList {
    log.i('streamMyGroceryList start');

    return _databaseService.streamMyGroceryList;
  }

  //----------------------------------------------------------------------------
  Future deleteCatagory({
    required String catagoryName,
  }) async {
    return _databaseService.deleteCatagoryFromCollection(
        catagoryName: catagoryName);
  }

  //----------------------------------------------------------------------------
  Future addCatagory({
    required String catagoryName,
  }) async {
    return _databaseService.addCatagoryCollection(catagoryName: catagoryName);
  }

  //----------------------------------------------------------------------------
  Future<void> deletedItem() {
    return _databaseService.deletedItem();
  }

  //----------------------------------------------------------------------------
  // * Setup initial database collection
  Future? initDatabaseSetup() async {
    // * create a new document for the user with the uid
    final List<Catagory> dairyList = [];
    final List<Catagory> vegetablesList = [];
    final List<Catagory> fruitsList = [];
    final List<Catagory> breadBakeryList = [];
    final List<Catagory> dryGoodsList = [];
    final List<Catagory> frozenFoodsList = [];
    final List<Catagory> beveragesList = [];
    final List<Catagory> cleanersList = [];
    final List<Catagory> personalCareList = [];
    final List<Catagory> otherList = [];
    final MyGroceryList mylist = MyGroceryList(
        dairyList: dairyList,
        vegetableList: vegetablesList,
        fruitsList: fruitsList,
        breadBakeryList: breadBakeryList,
        dryGoodsList: dryGoodsList,
        frozenFoodsList: frozenFoodsList,
        beveragesList: beveragesList,
        cleanersList: cleanersList,
        personalCareList: personalCareList,
        otherList: otherList);

    await _databaseService.updateUserData(myGroceryList: mylist);
  }
}
