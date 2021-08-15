import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/logging.dart';

class CatagoryItemsViewModel with ChangeNotifier {
  final AuthService myAuth = AuthService();
  late String? currentUserId = myAuth.auth.currentUser?.uid;

  num _count = 0.00;
  num get count => _count;
  final log = logger(CatagoryItemsViewModel);

  DatabaseService get _databaseService {
    return DatabaseService(uid: currentUserId);
  }

  //------------------------------------------------------------------------------
  // * get stream of grocerylist
  Stream<Map<String, dynamic>?> get streamMyGroceryList {
    log.i('streamMyGroceryList start');

    return _databaseService.streamMyGroceryList;
  }

  //----------------------------------------------------------------------------
  Future<void> deletedItem() {
    return _databaseService.deletedItemCollection();
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

//------------------------------------------------------------------------------
  Future add({required num price}) async {
    _count += price;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  void minus({required num price}) {
    _count -= price;
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future reset() async {
    _count = 0.00;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}
