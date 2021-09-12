/// This file contains setup function that are created to remove duplicate
/// code from tests and make them more readable
///  https://github.com/FilledStacks/boxtout/blob/main/src/clients/customer/test/helpers/test_helpers.dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/services/total_price_service.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_data.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(returnNullOnMissingStub: true),
  MockSpec<DialogService>(returnNullOnMissingStub: true),
  MockSpec<TotalPriceService>(returnNullOnMissingStub: true),
  MockSpec<DatabaseService>(returnNullOnMissingStub: true),
  MockSpec<FirebaseAuthenticationService>(returnNullOnMissingStub: true),
])
MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();

  when(service.showDialog(
          barrierDismissible: anyNamed('barrierDismissible'),
          buttonTitle: anyNamed('buttonTitle'),
          buttonTitleColor: anyNamed('buttonTitleColor'),
          cancelTitle: anyNamed('cancelTitle'),
          cancelTitleColor: anyNamed('cancelTitleColor'),
          description: anyNamed('description'),
          dialogPlatform: anyNamed('dialogPlatform'),
          title: anyNamed('title')))
      .thenAnswer((realInvocation) => Future.value(DialogResponse()));

  locator.registerSingleton<DialogService>(service);
  return service;
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockDatabaseService getAndRegisterDatabaseService() {
  _removeRegistrationIfExists<DatabaseService>();
  final service = MockDatabaseService();

  when(service.addUpdateItemInCollection(
          catagoryName: tkCatagoryName, catagoryItemJson: ktCatagoryItemJson))
      .thenAnswer((realInvocation) => Future.value('Success'));

  when(service.deleteItemFromCataogryList(
          catagoryName: tkCatagoryName, mapList: tkitemListMap))
      .thenAnswer((realInvocation) => Future.value('Success'));

  // Stream<Map<String, dynamic>> dummyStream = {};
  // when(service.streamMyGroceryListMap)
  //     .thenAnswer((realInvocation) => Future.value('Success'));

  locator.registerSingleton<DatabaseService>(service);
  return service;
}

MockFirebaseAuthenticationService getAndRegisterFirebaseService() {
  _removeRegistrationIfExists<FirebaseAuthenticationService>();
  final _service = MockFirebaseAuthenticationService();

  when(_service.currentUser?.uid).thenAnswer((realInvocation) => 'abc');
  locator.registerSingleton<FirebaseAuthenticationService>(_service);
  return _service;
}

MockTotalPriceService getAndRegisterTotalPriceService() {
  _removeRegistrationIfExists<TotalPriceService>();
  final service = MockTotalPriceService();
  // final _totalPriceService = TotalPriceService();
  const num price = 0.0;
  const bool success = true;

  when(service.count).thenAnswer((realInvocation) => price);

  when(service.addItemPrice(itemName: kItemNameMixVeg, price: 2))
      .thenAnswer((realInvocation) => Future.value(success));

  when(service.removeItemPrice(itemName: kItemNameMilk))
      .thenAnswer((realInvocation) => Future.value(success));

  when(service.reset()).thenAnswer((realInvocation) => Future.value(success));

  when(service.addItemPrice(itemName: kItemNameMilk, price: 0))
      .thenAnswer((realInvocation) => Future.value(success));

  when(service.removeItemPrice(itemName: kItemNameMilk))
      .thenAnswer((realInvocation) => Future.value(success));

  locator.registerSingleton<TotalPriceService>(service);

  return service;
}

void registerServices() {
  getAndRegisterDialogService();
  getAndRegisterNavigationService();
  getAndRegisterTotalPriceService();
  getAndRegisterFirebaseService();
}

void unregisterServices() {
  locator.unregister<NavigationService>();
  locator.unregister<DialogService>();
  locator.unregister<TotalPriceService>();
  locator.unregister<FirebaseAuthenticationService>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
