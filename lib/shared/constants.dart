import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/dimensions.dart';

//------------------------------------------------------------------------------
const Color kcRedColor = Color(0xfff44336);
const Color kcOrangeColor = Color(0xffff9800);
//------------------------------------------------------------------------------
const kTextFormInputDecoration = InputDecoration(
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent),
  ),
);

//------------------------------------------------------------------------------
const kAddItemPopupTextFormInputDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.deepPurpleAccent),
));

//------------------------------------------------------------------------------
SizedBox kSizedBox = SizedBox(
  height: Dimensions.sizeBoxHeight20,
);

//------------------------------------------------------------------------------
ButtonStyle? kButtonSytle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(
    Colors.deepPurpleAccent,
  ),
);
//------------------------------------------------------------------------------
// const Text ktbTextStyleTextButton = Text()
//                         textAlign: TextAlign.center,
//                       );
//------------------------------------------------------------------------------
const Divider kDivider = Divider(
  // color: Colors.deepPurpleAccent,
  height: 3,
);

//------------------------------------------------------------------------------
const String kDairy = 'Dairy';
const String kVegetables = 'Vegetables';
const String kFruits = 'Fruits';
const String kBakery = 'Bakery';
const String kDry = 'Dry Foods';
const String kFrozenFoods = 'Frozen Foods';
const String kBeverages = 'Beverages';
const String kCleaners = 'Cleaners';
const String kPersonalCare = 'Personal Care';
const String kOther = 'Other';

const String kName = 'name';
const String kToBuy = 'toBuy';
const String kPrice = 'price';
const String kQuantity = 'quantity';
const String kMyGroceryList = 'myGroceryList';

//------------------------------------------------------------------------------
const String kBuyMeCoffee = 'Buy me Coffee';
const String kContact = 'Contact';
const String kSignOut = 'Sign Out';
const String kAppVersion = 'App Version';
const String kLoading = 'Loading....';
const String kQTY = 'QTY';

const String kAppTitle = 'My Groceries List';
const String kTabBuy = 'Buy';
const String kTabBought = 'Bought';
const String kTotal = 'Total';
const String kNoItem = 'No Item';

//------------------------------------------------------------------------------
const String kDrawerBackgroundImg = 'assets/images/background.png';
const String kAssetsPath = 'assets/images/';
const String kImageExt = '.png';
