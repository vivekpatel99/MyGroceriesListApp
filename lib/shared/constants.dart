import 'package:flutter/material.dart';

const kTextFormInputDecoration = InputDecoration(
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent),
  ),
);

const kSizedBox = SizedBox(
  height: 20.0,
);

ButtonStyle? kButtonSytle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(
    Colors.deepPurpleAccent,
  ),
);

const Divider kDivider = Divider(
  color: Colors.deepPurpleAccent,
  height: 3,
);
const TextStyle kDrawerManuTextStyle = TextStyle(fontSize: 18);

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
const String kMyGroceryList = 'myGroceryList';
