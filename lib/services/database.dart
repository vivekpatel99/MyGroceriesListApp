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

  // * collection reference
  final CollectionReference groceryListsCollection =
      FirebaseFirestore.instance.collection('groceryList');

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

  // * get grocerylist from snapshot
  List<MyGroceryList> _groceryListFromSnapshot(QuerySnapshot snapshot) {
    print('#############');

    return snapshot.docs.map((doc) {
      final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      final MyGroceryList _myGroceryList = MyGroceryList.fromJson(data);
      print(_myGroceryList.dairy);
      // print('----');
      // final List<Dairy>? dairyList = data?['Dairy'] as List<Dairy>?;

      // print(dairyList);
      // final List<Vegetables>? vegetableList =
      //     data?['Vegetables'] as List<Vegetables>?;
      // final List<Fruits>? fruitsList = data?['Fruits'] as List<Fruits>?;

      // final MyGroceryList myGList = MyGroceryList(
      //   dairy: dairyList ?? [],
      //   vegetables: vegetableList ?? [],
      //   fruits: fruitsList ?? [],
      // );
      return _myGroceryList;
      // return MyGroceryList(
      //   dairy: dairyList ?? [],
      //   vegetables: vegetableList ?? [],
      //   fruits: fruitsList ?? [],
      // );
    }).toList();
  }

  // * Get grocerylist stream
  Stream<List<MyGroceryList>>? get groceryList {
    return groceryListsCollection.snapshots().map(_groceryListFromSnapshot);
  }
}
