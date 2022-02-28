import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerWidgetViewModel extends BaseViewModel {
  final log = getLogger('DrawerWidgetViewModel');
  final navigationService = locator<NavigationService>();

  final FirebaseAuthenticationService _authenticationService =
      locator<FirebaseAuthenticationService>();
  final AuthService _auth = AuthService();

  // ***********************************************************************
  String getUserName() => _auth.getUserName;
  // ***********************************************************************
  String getEmailAddress() => _auth.getemailAdrress;

  // ***********************************************************************
  void contactInfoOnTap() {
    log.i('contactInfoOnTap pressed');
    log.w('contactInfoOnTap NOT implemented');
  }

  // ***********************************************************************
  void buyMeACoffeeOnTap() {
    log.i('buyMeACoffeeOnTap pressed');
    log.w('buyMeACoffeeOnTap NOT implemented');
  }

  // ***********************************************************************
  void goBackToSignInPage() {
    navigationService.navigateTo(Routes.loginView);
  }

  // ***********************************************************************
  void signOut() {
    _authenticationService.logout();
  }
}
