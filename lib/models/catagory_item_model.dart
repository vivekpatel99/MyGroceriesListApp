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
    CatagoryItem(id: 1, catagoryName: 'Beverages', isCheck: false),
    CatagoryItem(id: 2, catagoryName: 'Bread/Bakery', isCheck: false),
    CatagoryItem(id: 3, catagoryName: 'Vegetables', isCheck: false),
    CatagoryItem(id: 4, catagoryName: 'Fruits', isCheck: false),
    CatagoryItem(
        id: 6, catagoryName: 'Dry/Baking(/Powder) Goods', isCheck: false),
    CatagoryItem(id: 7, catagoryName: 'Frozen Foods', isCheck: false),
    CatagoryItem(id: 8, catagoryName: 'Cleaners', isCheck: false),
    CatagoryItem(id: 9, catagoryName: 'Personal Care', isCheck: false),
    CatagoryItem(id: 10, catagoryName: 'Other', isCheck: false),
  ];
}
