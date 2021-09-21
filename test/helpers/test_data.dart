import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/shared/constants.dart';

/// This file contains the test data used in tests to remove non-deterministing behavior
const Map<String, num> tkFirebaseResponseMap = {
  'cheese': 2.99,
  'butter': 1.99,
  'apples': 1.99,
  'marcha': 2.50,
  'lot': 11
};
const String tkCatagoryName = 'Dairy';
final Catagory tkDairy = Catagory(name: 'milk', price: 0.99, quantity: '');
final Catagory tkCheese = Catagory(name: 'cheese', price: 2, quantity: '');
final Catagory tkApples = Catagory(name: 'apples', price: 0, quantity: '');

final List<Catagory> tkCatagoryItems = [tkDairy, tkCheese, tkApples];
final List<Catagory> tkCatagoryItemList = [tkDairy];
final List<Map<String, dynamic>> ktCatagoryItemJson =
    tkCatagoryItemList.map((e) => e.toJson()).toList();
const String kItemNameMixVeg = 'mixVeg';
const String kItemNameMilk = 'Milk';
final Map<String, dynamic> tkitemListMap = {
  kName: 'milk',
  kPrice: 0.0,
  kQuantity: 1,
  kToBuy: true
};

Stream<Map<String, dynamic>?> ktdummyMapStream() async* {
  for (int i = 0; i <= 10; i++) {
    yield tkitemListMap;
    await Future.delayed(const Duration(seconds: 1));
  }
}

final List<Catagory> dairyList = [];
final List<Catagory> tkvegetablesList = [];
final List<Catagory> tkfruitsList = [];
final List<Catagory> tkbreadBakeryList = [];
final List<Catagory> tkdryGoodsList = [];
final List<Catagory> tkfrozenFoodsList = [];
final List<Catagory> tkbeveragesList = [];
final List<Catagory> tkcleanersList = [];
final List<Catagory> tkpersonalCareList = [];
final List<Catagory> tkotherList = [];
final MyGroceryList tkmylist = MyGroceryList(
    dairyList: dairyList,
    vegetableList: tkvegetablesList,
    fruitsList: tkfruitsList,
    breadBakeryList: tkbreadBakeryList,
    dryGoodsList: tkdryGoodsList,
    frozenFoodsList: tkfrozenFoodsList,
    beveragesList: tkbeveragesList,
    cleanersList: tkcleanersList,
    personalCareList: tkpersonalCareList,
    otherList: tkotherList);
