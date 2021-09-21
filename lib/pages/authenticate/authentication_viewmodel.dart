import 'package:my_grocery_list/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>(); //19:00

  final String successRoute;
  AuthenticationViewModel({required this.successRoute});

  @override
  void setFormStatus() {}

  Future saveData() async {
    // view needed to be set to busy hence runBusyFuture used
    final result = await runBusyFuture(runAuthentication());
    if (!result.hasError) {
      // navigate to sucess route
      navigationService.replaceWith(successRoute);
    } else {
      setValidationMessage(result.errorMessage);
    }
  }

  Future<FirebaseAuthenticationResult> runAuthentication();
}
// duration 18.18
