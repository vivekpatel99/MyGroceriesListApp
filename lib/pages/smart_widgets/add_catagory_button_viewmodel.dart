import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/shared/my_extensions.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:stacked/stacked.dart';

class AddCatagoryButtonViewModel extends BaseViewModel {
  final CatagoryItemsViewModel _catagoryItemsViewModel =
      locator<CatagoryItemsViewModel>();
  final log = getLogger('AddCatagoryButtonViewModel');

  void addNewCatagory({required String newCatagory}) {
    if (newCatagory.isNotEmpty) {
      log.i('catagoryName: $newCatagory');
      _catagoryItemsViewModel.addCatagory(
          catagoryName: newCatagory.capitalize());
    }
  }
}
