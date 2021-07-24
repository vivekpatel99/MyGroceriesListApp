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
