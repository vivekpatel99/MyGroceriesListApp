import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/address_selection/address_selection_viewmodel.dart';
import 'package:stacked/stacked.dart';

// duration 20:34
class AddressSelectionView extends StatelessWidget {
  const AddressSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressSelectionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => AddressSelectionViewModel(),
    );
  }
}
