import 'package:my_grocery_list/models/item_model.dart';

class InventoryModel {
  // late ItemModel _item;
  final List<ItemModel> _buyItemList = [];
  final List<ItemModel> _boughtItemList = [];

  // ADD item into Inventory
  void add(ItemModel item) => _buyItemList.add(item);

  // Move item into Bought list
  void moveItemToBoughtList(ItemModel item) {
    _buyItemList.remove(item);
    _boughtItemList.add(item);
  }

  // Remove item from Bought list
  void removeFromBoughtList(ItemModel item) => _boughtItemList.add(item);
}
