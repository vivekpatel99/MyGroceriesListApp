import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//------------------------------------------------------------------------------
// create user object based on firebase user
  UserModel? _userFromFirebaseUser(User? userInfo) {
    return userInfo != null ? UserModel(uid: userInfo.uid) : null;
  }

//------------------------------------------------------------------------------
  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? _user) => _userFromFirebaseUser(_user));
  }

//------------------------------------------------------------------------------
  // sign in with email and password
  Future signInWithEmailAndPassord(
      {required String email, required String password}) async {
    try {
      final UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User _user = _result.user!;

      return _userFromFirebaseUser(_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//------------------------------------------------------------------------------
  // register with email and password
  Future signupWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      print('$email $password');
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      // * create a new document for the user with the uid
      final Dairy milk = Dairy(name: 'Milk');
      final Dairy cheese = Dairy(name: 'cheese');

      final Vegetables bringel = Vegetables(name: 'bringel');
      final Vegetables ginger = Vegetables(name: 'ginger');

      final Fruits melon = Fruits(name: 'melon');
      final Fruits watermelon = Fruits(name: 'watermelon');

      // Map<String, List<MyItemModel>> grocerylist = {
      //   'Dairy': [milk, cheese],
      //   'veg': [milk, cheese],
      //   'fruit': [milk, cheese],
      // };
      final List<Dairy> dairyList = [milk, cheese];
      final List<Vegetables> vegetablesList = [bringel, ginger];
      final List<Fruits> fruitsList = [melon, watermelon];

      MyGroceryList mylist = MyGroceryList(
          dairy: dairyList, vegetable: vegetablesList, fruits: fruitsList);

      print(mylist.toJson());
      await DatabaseService(uid: user.uid)
          .updateUserData(myGroceryList: mylist);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//------------------------------------------------------------------------------
  // sign in with email and password

//------------------------------------------------------------------------------
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
