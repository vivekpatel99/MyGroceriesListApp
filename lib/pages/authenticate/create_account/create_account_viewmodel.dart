import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:my_grocery_list/pages/authenticate/authentication_viewmodel.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';

import 'create_account_view.form.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final log = getLogger('CreateAccountViewModel');
  CreateAccountViewModel() : super(successRoute: Routes.homeView);

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() {
    log.i('runAuthentication');
    return _firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue ?? '',
        password: passwordValue ?? '',
        name: fullNameValue ?? '');
  }

  void navigationBack() => navigationService.back();
}
