import 'package:flutter/material.dart';
/*
TODO: add more properites into the model such as 
   I. two prices for comparision
   II. image of the item
*/

import 'package:flutter/widgets.dart';

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

// class ListItemModel {
//   final List<MyItemModel> listItems;
//   ListItemModel({
//     required this.listItems,
//   });

// }

// static final catagoryItemList = [
//   CatagoryItem(id: 1, catagoryName: 'Dairy', isCheck: false),
//   CatagoryItem(id: 2, catagoryName: 'Vegetables', isCheck: false),
//   CatagoryItem(id: 3, catagoryName: 'Fruits', isCheck: false),
//   CatagoryItem(id: 4, catagoryName: 'Bread/Bakery', isCheck: false),
//   CatagoryItem(
//       id: 5, catagoryName: 'Dry/Baking(/Powder) Goods', isCheck: false),
//   CatagoryItem(id: 6, catagoryName: 'Frozen Foods', isCheck: false),
//   CatagoryItem(id: 7, catagoryName: 'Beverages', isCheck: false),
//   CatagoryItem(id: 8, catagoryName: 'Cleaners', isCheck: false),
//   CatagoryItem(id: 9, catagoryName: 'Personal Care', isCheck: false),
//   CatagoryItem(id: 10, catagoryName: 'Other', isCheck: false),
// ];
// class MyGroceryList {
//   final Map<String, List<MyItemModel>> myGroceryList;
//   MyGroceryList({
//     required this.myGroceryList,
//   });
// }

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
// class Fruits {
// /*
// {
//   "name": "Watermelon",
//   "toBuy": true
// }
// */

//   String? name;
//   bool? toBuy;

//   Fruits({
//     this.name,
//     this.toBuy,
//   });
//   Fruits.fromJson(Map<String, dynamic> json) {
//     name = json["name"] as String;
//     toBuy = json["toBuy"] as bool;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["name"] = name;
//     data["toBuy"] = toBuy;
//     return data;
//   }
// }

// class Vegetables {
// /*
// {
//   "name": "Bringel",
//   "toBuy": true
// }
// */

//   String? name;
//   bool? toBuy;

//   Vegetables({
//     this.name,
//     this.toBuy,
//   });
//   Vegetables.fromJson(Map<String, dynamic> json) {
//     name = json["name"] as String;
//     toBuy = json["toBuy"] as bool;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["name"] = name;
//     data["toBuy"] = toBuy;
//     return data;
//   }
// }

class Catagory {
/*
{
  "name": "Milk",
  "toBuy": true
} 
*/

  late String name;
  late bool toBuy;

  Catagory({
    required this.name,
    this.toBuy = true,
  });
  Catagory.fromJson(Map<String, dynamic> json) {
    name = json["name"] as String;
    toBuy = json["toBuy"] as bool;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["toBuy"] = toBuy;
    return data;
  }
}

class MyGroceryList {
/*
{
  "Dairy": [
    {
      "name": "Milk",
      "toBuy": true
    }
  ],
  "Vegetable": [
    {
      "name": "Bringel",
      "toBuy": true
    }
  ],
  "Fruits": [
    {
      "name": "Watermelon",
      "toBuy": true
    }
  ]
} 
*/
  // CatagoryItem(id: 4, catagoryName: 'Bread/Bakery', isCheck: false),
  // CatagoryItem(
  //     id: 5, catagoryName: 'Dry/Baking(/Powder) Goods', isCheck: false),
  // CatagoryItem(id: 6, catagoryName: 'Frozen Foods', isCheck: false),
  // CatagoryItem(id: 7, catagoryName: 'Beverages', isCheck: false),
  // CatagoryItem(id: 8, catagoryName: 'Cleaners', isCheck: false),
  // CatagoryItem(id: 9, catagoryName: 'Personal Care', isCheck: false),
  // CatagoryItem(id: 10, catagoryName: 'Other', isCheck: false),

  List<Catagory>? dairyList;
  List<Catagory>? vegetableList;
  List<Catagory>? fruitsList;

  // List<Catagory?>? dreadBakery;
  // List<Catagory?>? dryGoods;
  // List<Catagory?>? frozenFoods;
  // List<Catagory?>? beverages;
  // List<Catagory?>? cleaners;
  // List<Catagory?>? personalCare;
  // List<Catagory?>? other;

  MyGroceryList({
    this.dairyList,
    this.vegetableList,
    this.fruitsList,
    // this.dreadBakery,
    // this.dryGoods,
    // this.frozenFoods,
    // this.beverages,
    // this.cleaners,
    // this.personalCare,
    // this.other,
  });
  factory MyGroceryList.fromJson(Map<String, dynamic> json) {
    List<Catagory>? _dairyList;
    if (json["Dairy"] != null) {
      final v = json["Dairy"];
      final arr0 = <Catagory>[];
      v.forEach((v) {
        arr0.add(Catagory.fromJson(v as Map<String, dynamic>));
      });
      _dairyList = arr0;
    }
    List<Catagory>? _vegetableList;
    if (json["Vegetables"] != null) {
      final v = json["Vegetables"];
      final arr0 = <Catagory>[];
      v.forEach((v) {
        arr0.add(Catagory.fromJson(v as Map<String, dynamic>));
      });
      _vegetableList = arr0;
    }
    List<Catagory>? _fruitsList;
    if (json["Fruits"] != null) {
      final v = json["Fruits"];
      final arr0 = <Catagory>[];
      v.forEach((v) {
        arr0.add(Catagory.fromJson(v as Map<String, dynamic>));
      });
      _fruitsList = arr0;
    }
    return MyGroceryList(
        dairyList: _dairyList,
        vegetableList: _vegetableList,
        fruitsList: _fruitsList);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dairyList != null) {
      final v = dairyList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["Dairy"] = arr0;
    }
    if (vegetableList != null) {
      final v = vegetableList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["Vegetables"] = arr0;
    }
    if (fruitsList != null) {
      final v = fruitsList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["Fruits"] = arr0;
    }
    return data;
  }
}

class MyGroceryListList {
/*
{
  "myGroceryList": {
    "Dairy": [
      {
        "name": "Milk",
        "toBuy": true
      }
    ],
    "Vegetable": [
      {
        "name": "Bringel",
        "toBuy": true
      }
    ],
    "Fruits": [
      {
        "name": "Watermelon",
        "toBuy": true
      }
    ]
  }
} 
*/

  MyGroceryList? myGroceryList;

  MyGroceryListList({
    this.myGroceryList,
  });
  MyGroceryListList.fromJson(Map<String, dynamic> json) {
    myGroceryList = (json["myGroceryList"] != null)
        ? MyGroceryList.fromJson(json["myGroceryList"] as Map<String, dynamic>)
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myGroceryList != null) {
      data["myGroceryList"] = myGroceryList!.toJson();
    }
    return data;
  }
}
