import 'package:flutter/material.dart';

class CatagoryItemsViewModel with ChangeNotifier {
  num _count = 0.00;
  num get count => _count;

  void add({required num price}) async {
    _count += price;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

  void minus({required num price}) {
    _count -= price;
    notifyListeners();
  }

  void reset() async {
    _count = 0.00;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}

// class TotalPriceCounter with ChangeNotifier {
//   num _count = 0.00;
//   num get count => _count;

//   void add({required num price}) async {
//     _count += price;
//     await Future.delayed(Duration(milliseconds: 1));
//     notifyListeners();
//   }

//   void minus({required num price}) {
//     _count -= price;
//     notifyListeners();
//   }

//   void reset() async {
//     _count = 0.00;
//     await Future.delayed(Duration(milliseconds: 1));
//     notifyListeners();
//   }
// }
