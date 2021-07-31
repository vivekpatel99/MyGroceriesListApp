import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/utils/logging.dart';

class DatabaseService {
  /*
  * 1. new user registers
  * 2. create new record in the grocerylist collection for that user
  * 3. each user will have his own documents in site the collection
  * 4. each documents have different groceryList
  */
//------------------------------------------------------------------------------
  // * collection reference
  final CollectionReference groceryListsCollection =
      FirebaseFirestore.instance.collection('groceryList');

  final String? uid;
  DatabaseService({this.uid});
  final log = logger(DatabaseService);

//------------------------------------------------------------------------------
  // * update tobuy status
  Future<void> moveToBuyBought({
    required String catagoryName,
    required List<dynamic> mapList,
  }) {
    final options = SetOptions(merge: true);
    log.i('moveToBuyBought start');
    log.d('uid: $uid');

    return groceryListsCollection
        .doc(uid)
        .set({
          catagoryName: mapList,
        }, options)
        .then((value) => log.i('moveToBuyBought Success'))
        .catchError((error) => log.e(error));
  }

//------------------------------------------------------------------------------
  // * delete items
  Future<void> deleteItemFromCataogry({
    required String catagoryName,
    required dynamic mapList,
  }) {
    log.i('deleteItemFromCataogry start');
    log.d('uid: $uid');
    return groceryListsCollection
        .doc(uid)
        .update({
          catagoryName: FieldValue.arrayRemove([mapList]),
        })
        .then((value) => log.i('deleteItemFromCataogry Success'))
        .catchError((error) => log.e(error));
  }

  //------------------------------------------------------------------------------
  // * update userdata
  Future addItem({
    required String catagoryName,
    required Catagory catagory,
  }) async {
/* 
{
  "Dairy": [
    {
      "name": "Milk",
      "toBuy": true
    },]

*/
    log.i('addItem start');
    log.d('uid: $uid');
    final options = SetOptions(merge: true);
    // List<dynamic> mapList = {catagoryName: catagory.toJason()};
    // print('$catagoryName : ${catagory.toJson()}');

    // {
    //       // catagoryName: catagory.toJson(),
    //       'Dairy': FieldValue.arrayUnion([
    //         {'name': 'Cheese', 'toBuy': true}
    //       ])
    //     }
    return groceryListsCollection
        .doc(uid)
        .set({
          catagoryName: FieldValue.arrayUnion([catagory.toJson()])
        }, options)
        .then((value) => log.i('addItem Success'))
        .catchError((error) => log.e(error));
  }

  //------------------------------------------------------------------------------
  // * update userdata
  Future updateUserData({required MyGroceryList myGroceryList}) async {
/* {
{
  "Dairy": [
    {
      "name": "Milk",
      "toBuy": true
    },
    {
      "name": "Cheese",
      "toBuy": true
    },
    {
      "name": "Butter",
      "toBuy": true
    }
  ],
  "Vegetable": [
    {
      "name": "Bringel",
      "toBuy": true
    },
    {
      "name": "Ginger",
      "toBuy": true
    }
  ],
  "Fruits": [
    {
      "name": "Watermelon",
      "toBuy": true
    },
    {
      "name": "melon",
      "toBuy": true
    }
  ]
}
}
*/
    log.i('updateUserData start');
    log.d('uid: $uid');
    return groceryListsCollection
        .doc(uid)
        .set(myGroceryList.toJson())
        .then((value) => log.i('updateUserData Success'))
        .catchError((error) => log.e(error));
  }

//------------------------------------------------------------------------------
  // * get grocerylist from snapshot
  // List<MyGroceryList> _groceryListFromSnapshot(QuerySnapshot snapshot) {
  //   log.i('_groceryListFromSnapshot start');
  //   final List<MyGroceryList> _groceryList = snapshot.docs.map((doc) {
  //     final data = (doc.data() as Map<String, dynamic>?) ?? {};
  //     return MyGroceryList.fromJson(data);
  //   }).toList();
  //   log.d('_groceryList: $_groceryList');
  //   return _groceryList;
  // }

//------------------------------------------------------------------------------
  // * Get grocerylist stream
  // Stream<List<MyGroceryList>> get groceryList {
  //   return groceryListsCollection.snapshots().map(_groceryListFromSnapshot);
  // }

//------------------------------------------------------------------------------
  // * get grocerylist from snapshot
  MyGroceryList myGroceryListFromSnapshot(DocumentSnapshot snapshot) {
    log.i('myGroceryListFromSnapshot start');
    final Map<String, dynamic>? myGroceryListJson =
        snapshot.data() as Map<String, dynamic>?;
    log.d('myGroceryListJson: $myGroceryListJson');
    return MyGroceryList.fromJson(myGroceryListJson);
  }

//------------------------------------------------------------------------------
  // * get stream of grocerylist
  Stream<MyGroceryList> get streamMyGroceryList {
    log.i('streamMyGroceryList start');
    return groceryListsCollection
        .doc(uid)
        .snapshots()
        .map(myGroceryListFromSnapshot);
  }
}
