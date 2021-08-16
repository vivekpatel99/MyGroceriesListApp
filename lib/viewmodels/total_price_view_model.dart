import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/logging.dart';

class TotalPriceViewModel with ChangeNotifier {
  num _count = 0.00;
  num get count => _count;
  final log = logger(TotalPriceViewModel);
  //------------------------------------------------------------------------------
  Future add({required num price}) async {
    _count += price;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }

//------------------------------------------------------------------------------
  void minus({required num price}) {
    _count -= price;
    notifyListeners();
  }

//------------------------------------------------------------------------------
  Future reset() async {
    _count = 0.00;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}
