import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/pages/total_price/total_price_view_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class CatagoryItemsViewModel {
  final TotalPriceViewModelOld totalPrice = TotalPriceViewModelOld();
  final FirebaseAuthenticationService auth =
      locator<FirebaseAuthenticationService>();
  final log = getLogger('CatagoryItemsViewModel');
  Map<String, dynamic>? _myGroceryList = {};
  String? get currentUserId {
    // final AuthService myAuth = AuthService();
    final String? currentUserId = auth.currentUser?.uid;
    return currentUserId;
  }

  //------------------------------------------------------------------------------
  // REFORMATE to update the values
  set myGroceryList(Map<String, dynamic>? myMapList) {
    _myGroceryList = myMapList;
  }

  //------------------------------------------------------------------------------
  Map<String, dynamic>? get myGroceryList => _myGroceryList;

  //------------------------------------------------------------------------------
  DatabaseService get _databaseService {
    log.i(currentUserId);
    return DatabaseService(uid: currentUserId);
  }

  //------------------------------------------------------------------------------
  int itemFoundInCatagoryItems(
      {required List<Catagory> catagoryItems, required String itemName}) {
    return catagoryItems.indexWhere(
        (element) => element.name.toLowerCase() == itemName.toLowerCase());
  }

  //------------------------------------------------------------------------------
  Future<String> addUpdateItem({
    required String catagoryName,
    required List<Catagory> catagoryItemList,
  }) async {
    final List<Map<String, dynamic>> catagoryItemJson =
        catagoryItemList.map((e) => e.toJson()).toList();

    // final catagoryItemJsonUniq = catagoryItemList.toSet().toList();

    log.d('catagoryItemJson: $catagoryItemJson');
    return _databaseService.addUpdateItemInCollection(
        catagoryName: catagoryName, catagoryItemJson: catagoryItemJson);
  }

  //------------------------------------------------------------------------------
  Future<String> moveToBuyBought(
      {required String itemName,
      required String catagoryTitle,
      required Catagory catagory,
      required List<dynamic> catagoryItemList}) {
    final catagoryItems = catagoryItemList
        .map<Catagory>(
            (json) => Catagory.fromJson(json as Map<String, dynamic>))
        .toList();
    final int foundItemIndex = itemFoundInCatagoryItems(
        catagoryItems: catagoryItems, itemName: itemName);
    // final int foundItemIndex =
    //     catagoryItems.indexWhere((element) => element.name == itemName);

    catagoryItems[foundItemIndex] = catagory;
    return addUpdateItem(
      catagoryName: catagoryTitle,
      catagoryItemList: catagoryItems,
    );
  }

//------------------------------------------------------------------------------
  // * delete items
  Future<String> deleteItemFromCataogry({
    required String catagoryName,
    required Map<String, dynamic> mapList,
  }) {
    return _databaseService.deleteItemFromCataogryList(
        catagoryName: catagoryName, mapList: mapList);
  }

  //------------------------------------------------------------------------------
  // * get stream of grocerylist
  Stream<Map<String, dynamic>?> get streamMyGroceryList {
    log.i('streamMyGroceryList start');

    return _databaseService.streamMyGroceryListMap;
  }

  //----------------------------------------------------------------------------
  Future<String> deleteCatagory({
    required String catagoryName,
  }) async {
    return _databaseService.deleteCatagoryFromCollection(
        catagoryName: catagoryName);
  }

  //----------------------------------------------------------------------------
  Future<String> addCatagory({
    required String catagoryName,
  }) async {
    return _databaseService.addCatagoryCollection(catagoryName: catagoryName);
  }

  //----------------------------------------------------------------------------
  Future<String> deleteAllItems() {
    return _databaseService.deletedItemFromCatagoryList();
  }

  //----------------------------------------------------------------------------
  // * Setup initial database collection
  Future<String> initDatabaseSetup() {
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

    return _databaseService.updateUserData(myGroceryList: mylist);
  }
}
