import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // late User userInfo;
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

  // String get userId {
  //   return userInfo.uid;
  // }

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
      // print('$email $password');
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User userInfo = result.user!;

      // * create a new document for the user with the uid
      // final Catagory milk = Catagory(name: 'Milk');
      // final Catagory cheese = Catagory(name: 'cheese');

      // final Catagory bringel = Catagory(name: 'bringel');
      // final Catagory ginger = Catagory(name: 'ginger');

      // final Catagory melon = Catagory(name: 'melon');
      // final Catagory watermelon = Catagory(name: 'watermelon');

      // Map<String, List<MyItemModel>> grocerylist = {
      //   'Dairy': [milk, cheese],
      //   'veg': [milk, cheese],
      //   'fruit': [milk, cheese],
      // };

      final List<Catagory> dairyList = [];
      final List<Catagory> vegetablesList = [];
      final List<Catagory> fruitsList = [];
      final List<Catagory> breadBakeryList = [];
      final List<Catagory> dryGoodsList = [];
      final List<Catagory> frozenFoodsList = [];
      final List<Catagory> beveragesList = [];
      final List<Catagory> cleanersList = [];
      final List<Catagory> personalCareList = [];
      final List<Catagory> otherList = [];
      final MyGroceryList mylist = MyGroceryList(
          dairyList: dairyList,
          vegetableList: vegetablesList,
          fruitsList: fruitsList,
          breadBakeryList: breadBakeryList,
          dryGoodsList: dryGoodsList,
          frozenFoodsList: frozenFoodsList,
          beveragesList: beveragesList,
          cleanersList: cleanersList,
          personalCareList: personalCareList,
          otherList: otherList);

      await DatabaseService(uid: userInfo.uid)
          .updateUserData(myGroceryList: mylist);

      //     .updateUserData
      return _userFromFirebaseUser(userInfo);
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
