import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.router.dart';
import 'package:my_grocery_list/pages/authenticate/authentication_viewmodel.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';

import 'create_account_view.form.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  CreateAccountViewModel() : super(successRoute: Routes.createAccountView);

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() {
    return _firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue ?? '', password: passwordValue ?? '');
  }

  void navigationBack() => navigationService.back();
}
