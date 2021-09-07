import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:my_grocery_list/services/database.dart';

class TestDatabaseService extends DatabaseService {
  static const String kGroceryList = 'groceryList';
  final instance = FakeFirebaseFirestore();

  TestDatabaseService({required String? uid}) : super(uid: uid);

  @override
  CollectionReference<Map<String, dynamic>> get groceryListsCollection =>
      instance.collection(kGroceryList);
}

void main() {
  // const String uid = 'abc';
  // final TestDatabaseService databaseService = TestDatabaseService(uid: uid);
  // setUp(() {});
  // group('Database Service -', () {
  //   group('deleteItemFromCataogryList -', () {
  //     test('deleteItemFromCataogryList will return success', () async {
  //       final result = await databaseService.deleteItemFromCataogryList(
  //           catagoryName: tkCatagoryName, mapList: tkDairy.toJson());
  //       expect(result, 'Success');

  //       final result2 = await databaseService.deleteItemFromCataogryList(
  //           catagoryName: tkCatagoryName, mapList: {});
  //       expect(result2, 'Success');
  //     });
  //   });
  // });
}
