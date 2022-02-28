import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerWidgetViewModel extends BaseViewModel {
  final log = getLogger('DrawerWidgetViewModel');
  final navigationService = locator<NavigationService>();

  void goBackToSignInPage() {
    navigationService.navigateTo(Routes.loginView);
  }
}
