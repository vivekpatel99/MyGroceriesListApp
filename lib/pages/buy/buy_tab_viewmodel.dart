import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:stacked/stacked.dart';

class BuyTabViewModel extends StreamViewModel<Map<String, dynamic>?> {
  final _catagoryItemsService = locator<CatagoryItemsViewModel>();
  final log = logger(BuyTabViewModel);
  @override
  Stream<Map<String, dynamic>?> get stream {
    log.i('streamMyGroceryList start');

    return _catagoryItemsService.streamMyGroceryList;
  }
}
