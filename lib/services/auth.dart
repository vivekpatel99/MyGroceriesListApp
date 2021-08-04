import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/utils/logging.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final log = logger(AuthService);

//------------------------------------------------------------------------------
// * create user object based on firebase user
  UserModel? _userFromFirebaseUser(User? userInfo) {
    log.i('_userFromFirebaseUser starts');
    log.d('uidd ${userInfo?.uid}');
    return userInfo != null ? UserModel(uid: userInfo.uid) : null;
  }

//------------------------------------------------------------------------------
  FirebaseAuth get auth {
    log.i('auth called');
    return _auth;
  }

//------------------------------------------------------------------------------
  String get getemailAdrress {
    log.i('auth called');

    return auth.currentUser?.email ?? '';
  }

//------------------------------------------------------------------------------
  Stream<UserModel?> get user {
    log.i('user called');
    return _auth
        .authStateChanges()
        .map((User? _user) => _userFromFirebaseUser(_user));
  }

  // String get userId {
  //   return userInfo.uid;
  // }

//------------------------------------------------------------------------------
  // * sign in with email and password
  Future signInWithEmailAndPassord(
      {required String email, required String password}) async {
    log.i('signInWithEmailAndPassord starts');
    try {
      final UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User _user = _result.user!;
      DatabaseService(uid: _user.uid);
      log.d('uid of new user ${_user.uid}');
      return _userFromFirebaseUser(_user);
    } catch (error) {
      log.e(error);
      return null;
    }
  }

//------------------------------------------------------------------------------
  // * sign in with email and password
  Future resetPassword({required String email}) async {
    log.i('resetPassword starts');

    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => log.i('Password is reset'))
        .catchError((error) => log.e(error));
  }

//------------------------------------------------------------------------------
  // register with email and password
  Future signupWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      log.i('signupWithEmailAndPassword starts');
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User userInfo = result.user!;
      await DatabaseService(uid: userInfo.uid).initDatabaseSetup();
      // * create a new document for the user with the uid
      // final List<Catagory> dairyList = [];
      // final List<Catagory> vegetablesList = [];
      // final List<Catagory> fruitsList = [];
      // final List<Catagory> breadBakeryList = [];
      // final List<Catagory> dryGoodsList = [];
      // final List<Catagory> frozenFoodsList = [];
      // final List<Catagory> beveragesList = [];
      // final List<Catagory> cleanersList = [];
      // final List<Catagory> personalCareList = [];
      // final List<Catagory> otherList = [];
      // final MyGroceryList mylist = MyGroceryList(
      //     dairyList: dairyList,
      //     vegetableList: vegetablesList,
      //     fruitsList: fruitsList,
      //     breadBakeryList: breadBakeryList,
      //     dryGoodsList: dryGoodsList,
      //     frozenFoodsList: frozenFoodsList,
      //     beveragesList: beveragesList,
      //     cleanersList: cleanersList,
      //     personalCareList: personalCareList,
      //     otherList: otherList);

      // await DatabaseService(uid: userInfo.uid)
      //     .updateUserData(myGroceryList: mylist);

      //     .updateUserData
      return _userFromFirebaseUser(userInfo);
    } catch (error) {
      log.e(error);
      return null;
    }
  }

//------------------------------------------------------------------------------
  // sign in with email and password

//------------------------------------------------------------------------------
  // sign out
  Future signOut() async {
    log.i('signOut');
    try {
      return await _auth.signOut();
    } catch (error) {
      log.e(error);
      return null;
    }
  }
}
