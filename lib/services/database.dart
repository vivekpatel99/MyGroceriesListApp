import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_grocery_list/models/item_model.dart';

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

//------------------------------------------------------------------------------
  // * update tobuy status
  Future<void> moveToBuyBought({
    required String catagoryName,
    required List<dynamic> mapList,
  }) {
    final options = SetOptions(merge: true);
    print('####### MovetoBuy');
    print(uid);
    return groceryListsCollection
        .doc(uid)
        .set({
          catagoryName: mapList,
        }, options)
        .then((value) => print('Done'))
        .catchError((error) => print(error.toString()));
  }

//------------------------------------------------------------------------------
  // * delete items
  Future<void> deleteItemFromCataogry({
    required String catagoryName,
    required dynamic mapList,
  }) {
    return groceryListsCollection
        .doc(uid)
        .update({
          catagoryName: FieldValue.arrayRemove([mapList]),
        })
        .then((value) => print('Done'))
        .catchError((error) => print(error.toString()));
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
        .then((value) => print('Done'))
        .catchError((error) => print(error.toString()));
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
    // groceryListsCollection.doc(uid).set(myGroceryList.toJson());

    // print('########## groceryListsCollection');
    // print('${groceryListsCollection.doc(uid).get()}');
    return groceryListsCollection.doc(uid).set(myGroceryList.toJson());
  }

//------------------------------------------------------------------------------
  // * get grocerylist from snapshot
  List<MyGroceryList> __groceryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = (doc.data() as Map<String, dynamic>?) ?? {};
      return MyGroceryList.fromJson(data);
    }).toList();
  }

//------------------------------------------------------------------------------
  // * Get grocerylist stream
  Stream<List<MyGroceryList>> get _groceryList {
    return groceryListsCollection.snapshots().map(_groceryListFromSnapshot);
  }

//##############################################################################
  // * get grocerylist from snapshot
  List<MyGroceryList> _groceryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // if (doc.id == uid) {
      final data = (doc.data() as Map<String, dynamic>?) ?? {};
      // print('####');
      // print('$data');
      // final MyGroceryList _myGroceryList = MyGroceryList.fromJson(data);
      return MyGroceryList.fromJson(data);
    }).toList();
  }

//------------------------------------------------------------------------------
  // * Get grocerylist stream
  Stream<List<MyGroceryList>> get groceryList {
    // final FirebaseAuth auth = AuthService().auth;
    // final User? currentuser = auth.currentUser as User;
    // final String userId = (currentuser?.uid ?? '');

    // Map<String, dynamic>? data;
    // final docSnapshots = groceryListsCollection.doc(uid);
    // docSnapshots.snapshots().listen((docSnapshot) {
    //   data = (docSnapshot.data() as Map<String, dynamic>?) ?? {};
    //   if ((docSnapshot.exists as bool)) {
    //     print('####################### docSnapshot');
    //     print(data);
    //   } else {
    //     data = null;
    //   }
    // });
    // print('##########');
    // Map<String, dynamic>? datamore =
    // await(docSnapshots.get() as Map<String, dynamic>?) ?? {};
    // print(datamore);

    // Stream<Map<String, dynamic>> documentStream =
    //     groceryListsCollection.doc(uid).snapshots().listen((docSnapshot) {
    //   if (docSnapshot.exists) {
    //     final Stream<Map<String, dynamic>>? data =
    //         (docSnapshot.data() as Map<String, dynamic>?);
    //   }
    // });
    // bla.map((event) {
    //   print('####');
    //   final Map<String, dynamic> data =
    //       (event.data() as Map<String, dynamic>?) ?? {};
    //   print(data['Dairy']);
    //   return data;
    // }).toList();

    // print('--------- get groceryList ----- uid');
    // print(uid);
    // final Future<DocumentSnapshot<Map<String, dynamic>>>? mylist =
    //     groceryListsCollection.doc(uid).get();
    // print(bla);

    return groceryListsCollection.snapshots().map(_groceryListFromSnapshot);

    // return groceryListsCollection.snapshots().map((snapShot) => snapShot.docs
    //     .map((document) => MyGroceryList.fromJson(
    //         (document.data() as Map<String, dynamic>?) ?? {}))
    //     .toList());

    // return MyGroceryList.fromJson(data);
  }

  MyGroceryList myGroceryListFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = (snapshot.data() as Map<String, dynamic>?);

    return MyGroceryList.fromJson(data);
  }

  Stream<MyGroceryList> get currentDocument {
    return groceryListsCollection
        .doc(uid)
        .snapshots()
        .map(myGroceryListFromSnapshot);
  }
}
