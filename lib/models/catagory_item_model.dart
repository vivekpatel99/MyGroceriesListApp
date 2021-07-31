import 'package:my_grocery_list/shared/constants.dart';

class CatagoryItem {
  final int id;
  final String catagoryName;
  bool isCheck;

  CatagoryItem({
    required this.id,
    required this.catagoryName,
    required this.isCheck,
  });
}

/*
    Beverages – coffee/tea, juice, soda
    Bread/Bakery – sandwich loaves, dinner rolls, tortillas, bagels

    Canned/Jarred Goods – vegetables, spaghetti sauce, ketchup

    Dairy – cheeses, eggs, milk, yogurt, butter

    Dry/Baking Goods – cereals, flour, sugar, pasta, mixes

    Frozen Foods – waffles, vegetables, individual meals, ice cream
    Meat – lunch meat, poultry, beef, pork
    Produce – fruits, vegetables
    Cleaners – all- purpose, laundry detergent, dishwashing liquid/detergent
    Paper Goods – paper towels, toilet paper, aluminum foil, sandwich bags
    Personal Care – shampoo, soap, hand soap, shaving cream
    Other – baby items, pet items, batteries, greeting cards
*/
class CatagoryItemModel {
  static final catagoryItemList = [
    CatagoryItem(id: 1, catagoryName: kDairy, isCheck: false),
    CatagoryItem(id: 2, catagoryName: kVegetables, isCheck: false),
    CatagoryItem(id: 3, catagoryName: kFruits, isCheck: false),
    CatagoryItem(id: 4, catagoryName: kBakery, isCheck: false),
    CatagoryItem(id: 5, catagoryName: kDry, isCheck: false),
    CatagoryItem(id: 6, catagoryName: kFrozenFoods, isCheck: false),
    CatagoryItem(id: 7, catagoryName: kBeverages, isCheck: false),
    CatagoryItem(id: 8, catagoryName: kCleaners, isCheck: false),
    CatagoryItem(id: 9, catagoryName: kPersonalCare, isCheck: false),
    CatagoryItem(id: 10, catagoryName: kOther, isCheck: false),
  ];
}
