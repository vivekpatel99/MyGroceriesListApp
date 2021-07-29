import 'package:my_grocery_list/models/item_model.dart';

class UserModel {
  final String? uid;
  UserModel({
    this.uid,
  });
}

class UserData {
  final String? uid;
  final List<MyGroceryList> myGroceryList;
  UserData({
    required this.uid,
    required this.myGroceryList,
  });
}
