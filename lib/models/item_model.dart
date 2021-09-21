import 'package:flutter/material.dart';
/*
TODO: add more properites into the model such as 
   I. two prices for comparision
   II. image of the item
*/

import 'package:flutter/widgets.dart';
import 'package:my_grocery_list/shared/constants.dart';

class ItemModel {
  final String name; // name of item
  final String
      catagory; // catagory of item such as dairy, vagitables, fruits, beans, other
  bool status = true; // buy list or Bought list
  // final num price1; // save price for one place
  // final num price2; // save price for 2nd place

  ItemModel({
    required this.name,
    required this.catagory,
  });
  String id = UniqueKey().toString();
}

class MyItemModel {
  final String itemName;
  final bool toBuy;
  MyItemModel({
    required this.itemName,
    this.toBuy = true,
  });
}

class Catagory {
/*
{
  kname: "Milk",
  kToBuy: true
} 
*/

  late String name;
  late bool toBuy;
  late num price;
  late String quantity;

  Catagory({
    required this.name,
    this.toBuy = true,
    required this.price,
    required this.quantity,
  });
  Catagory.fromJson(Map<String, dynamic> json) {
    name = json[kName] as String;
    toBuy = json[kToBuy] as bool;
    price = json[kPrice] as num;
    quantity = json[kQuantity] as String;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[kName] = name;
    data[kToBuy] = toBuy;
    data[kPrice] = price;
    data[kQuantity] = quantity;
    return data;
  }
}

class MyGroceryList {
/*
{
  "Dairy": [
    {
      kname: "Milk",
      kToBuy: true
    }
  ],
  "Vegetable": [
    {
      kname: "Bringel",
      kToBuy: true
    }
  ],
  kFruits: [
    {
      kname: "Watermelon",
      kToBuy: true
    }
  ]
} 
*/

  List<Catagory>? dairyList;
  List<Catagory>? vegetableList;
  List<Catagory>? fruitsList;

  List<Catagory>? breadBakeryList;
  List<Catagory>? dryGoodsList;
  List<Catagory>? frozenFoodsList;
  List<Catagory>? beveragesList;
  List<Catagory>? cleanersList;
  List<Catagory>? personalCareList;
  List<Catagory>? otherList;

  MyGroceryList({
    this.dairyList,
    this.vegetableList,
    this.fruitsList,
    this.breadBakeryList,
    this.dryGoodsList,
    this.frozenFoodsList,
    this.beveragesList,
    this.cleanersList,
    this.personalCareList,
    this.otherList,
  });
  factory MyGroceryList.fromJson(Map<String, dynamic>? json) {
    //--------------------------------------------------------------------------
    List<Catagory>? _innerFromJson(
        {required String catName, required Map<String, dynamic>? json}) {
      if (json![catName] != null) {
        final v = json[catName];
        final arr0 = <Catagory>[];
        v.forEach((v) {
          arr0.add(Catagory.fromJson(v as Map<String, dynamic>));
        });
        return arr0;
      }
    }

    final List<Catagory>? _dairyList =
        _innerFromJson(catName: kDairy, json: json);
    // if (json["Dairy"] != null) {
    //   final v = json["Dairy"];
    //   final arr0 = <Catagory>[];
    //   v.forEach((v) {
    //     arr0.add(Catagory.fromJson(v as Map<String, dynamic>));
    //   });
    //   _dairyList = arr0;
    // }
    final List<Catagory>? _vegetableList =
        _innerFromJson(catName: kVegetables, json: json);

    final List<Catagory>? _fruitsList =
        _innerFromJson(catName: kFruits, json: json);

    final List<Catagory>? _breadBakeryList =
        _innerFromJson(catName: kBakery, json: json);

    final List<Catagory>? _dryGoodsList =
        _innerFromJson(catName: kDry, json: json);

    final List<Catagory>? _frozenFoodsList =
        _innerFromJson(catName: kFrozenFoods, json: json);

    final List<Catagory>? _beveragesList =
        _innerFromJson(catName: kBeverages, json: json);

    final List<Catagory>? _cleanersList =
        _innerFromJson(catName: kCleaners, json: json);

    final List<Catagory>? _personalCareList =
        _innerFromJson(catName: kPersonalCare, json: json);

    final List<Catagory>? _otherList =
        _innerFromJson(catName: kOther, json: json);

    return MyGroceryList(
        dairyList: _dairyList,
        vegetableList: _vegetableList,
        fruitsList: _fruitsList,
        breadBakeryList: _breadBakeryList,
        dryGoodsList: _dryGoodsList,
        frozenFoodsList: _frozenFoodsList,
        beveragesList: _beveragesList,
        cleanersList: _cleanersList,
        personalCareList: _personalCareList,
        otherList: _otherList);
  }
  Map<String, dynamic> toJson() {
    List<dynamic>? _innerToJson({required List<Catagory>? catList}) {
      if (catList != null) {
        final v = catList;
        final arr0 = [];
        v.forEach((v) {
          arr0.add(v.toJson());
        });
        return arr0;
      }
    }

    final Map<String, dynamic> data = <String, dynamic>{};
    data[kDairy] = _innerToJson(catList: dairyList);
    // if (dairyList != null) {
    //   final v = dairyList;
    //   final arr0 = [];
    //   v!.forEach((v) {
    //     arr0.add(v.toJson());
    //   });
    //   data["Dairy"] = arr0;
    // }
    data[kVegetables] = _innerToJson(catList: vegetableList);

    data[kFruits] = _innerToJson(catList: fruitsList);

    data[kBakery] = _innerToJson(catList: breadBakeryList);
    data[kDry] = _innerToJson(catList: dryGoodsList);
    data[kFrozenFoods] = _innerToJson(catList: frozenFoodsList);
    data[kBeverages] = _innerToJson(catList: beveragesList);
    data[kCleaners] = _innerToJson(catList: cleanersList);
    data[kPersonalCare] = _innerToJson(catList: personalCareList);
    data[kOther] = _innerToJson(catList: otherList);

    return data;
  }
}

// class MyGroceryListList {
// /*
// {
//   kMyGroceryList: {
//     "Dairy": [
//       {
//         kname: "Milk",
//         kToBuy: true
//       }
//     ],
//     "Vegetable": [
//       {
//         kname: "Bringel",
//         kToBuy: true
//       }
//     ],
//     kFruits: [
//       {
//         kname: "Watermelon",
//         kToBuy: true
//       }
//     ]
//   }
// } 
// */

//   MyGroceryList? myGroceryList;

//   MyGroceryListList({
//     this.myGroceryList,
//   });
//   MyGroceryListList.fromJson(Map<String, dynamic> json) {
//     myGroceryList = (json[kMyGroceryList] != null)
//         ? MyGroceryList.fromJson(json[kMyGroceryList] as Map<String, dynamic>)
//         : null;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (myGroceryList != null) {
//       data[kMyGroceryList] = myGroceryList!.toJson();
//     }
//     return data;
//   }
// }
