import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:my_grocery_list/pages/authenticate/authentication_viewmodel.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';

import 'login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  late final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final log = getLogger('LoginViewModel');
  LoginViewModel() : super(successRoute: Routes.homeView);

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() {
    log.i('runAuthentication');
    return _firebaseAuthenticationService.loginWithEmail(
        email: emailValue ?? '', password: passwordValue ?? '');
  }

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountView);
}
