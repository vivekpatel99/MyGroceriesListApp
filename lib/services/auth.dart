import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';

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
    log.i('auth getemailAdrress');

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

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      log.i('Success Signin');
      final UserCredential _result = value;
      final User _user = _result.user!;
      DatabaseService(uid: _user.uid);
      log.d('uid of new user ${_user.uid}');
      return _userFromFirebaseUser(_user);
    }).catchError((error) {
      log.e(error);
      return null;
    });
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
    log.i('signupWithEmailAndPassword starts');

    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User userInfo = result.user!;
      await CatagoryItemsViewModel().initDatabaseSetup();
      // await DatabaseService(uid: userInfo.uid).initDatabaseSetup();
      log.i('User Sign in successful');
      return _userFromFirebaseUser(userInfo);
    } catch (error) {
      log.e(error);
      return null;
    }
  }

//------------------------------------------------------------------------------
  // sign out
  Future signOut() async {
    log.i('signOut');
    _auth
        .signOut()
        .then((_) => log.i('Sign out Successful'))
        .catchError((error) => log.e(error));
  }
}
