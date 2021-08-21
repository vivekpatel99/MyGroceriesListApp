import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/address_selection/address_selection_view.dart';
import 'package:my_grocery_list/pages/authenticate/create_account/create_account_view.dart';
import 'package:my_grocery_list/pages/authenticate/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  CupertinoRoute(page: AddressSelectionView),
  CupertinoRoute(page: CreateAccountView),
  CupertinoRoute(page: LoginView, initial: true),
], dependencies: [
  LazySingleton(classType: NavigationService),
  Singleton(classType: FirebaseAuthenticationService)
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
