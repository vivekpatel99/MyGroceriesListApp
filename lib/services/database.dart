import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_grocery_list/models/item_model.dart';

class DatabaseService {
  /*
  * 1. new user registers
  * 2. create new record in the grocerylist collection for that user
  * 3. each user will have his own documents in site the collection
  * 4. each documents have different groceryList
  */
  final String? uid;
  DatabaseService({
    this.uid,
  });

//------------------------------------------------------------------------------
  // * collection reference
  final CollectionReference groceryListsCollection =
      FirebaseFirestore.instance.collection('groceryList');

//------------------------------------------------------------------------------
  // * update tobuy status
  Future<void> moveToBuyBought({
    required String catagoryName,
    required List<dynamic> mapList,
  }) {
    final options = SetOptions(merge: true);

    return groceryListsCollection
        .doc(uid)
        .set({
          catagoryName: mapList,
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
  List<MyGroceryList> _groceryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = (doc.data() as Map<String, dynamic>?) ?? {};
      final MyGroceryList _myGroceryList = MyGroceryList.fromJson(data);
      return _myGroceryList;
    }).toList();
  }

//------------------------------------------------------------------------------
  // * Get grocerylist stream
  Stream<List<MyGroceryList>>? get groceryList {
    return groceryListsCollection.snapshots().map(_groceryListFromSnapshot);
  }
}
