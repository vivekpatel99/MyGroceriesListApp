import 'package:my_grocery_list/pages/authenticate/create_account/create_account_view.dart';
import 'package:my_grocery_list/pages/authenticate/login/login_view.dart';
import 'package:my_grocery_list/pages/home/home_view.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/services/total_price_service.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: CreateAccountView),
    CupertinoRoute(page: HomeView),
    CupertinoRoute(page: LoginView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: TotalPriceService),
    LazySingleton(classType: CatagoryItemsViewModel),
    Singleton(classType: FirebaseAuthenticationService)
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
