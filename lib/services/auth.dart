import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AuthService {
  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseAuth _auth = _firebaseAuthenticationService.firebaseAuth;
  final log = getLogger('AuthService');

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

    return _firebaseAuthenticationService.firebaseAuth;
  }

//------------------------------------------------------------------------------
  String get getemailAdrress {
    log.i('auth getemailAdrress');

    return auth.currentUser?.email ?? '';
  }

//------------------------------------------------------------------------------
  String get getUserName {
    log.i('auth getUserName');

    log.i(_firebaseAuthenticationService.currentUser?.displayName);
    return auth.currentUser?.displayName ?? 'No Name';
  }

//------------------------------------------------------------------------------
  Stream<UserModel?> get user {
    log.i('user called');
    return _firebaseAuthenticationService.firebaseAuth
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

    _firebaseAuthenticationService.firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      log.i('Success Signin');
      final UserCredential _result = value;
      final User _user = _result.user!;
      // DatabaseService(uid: _user.uid);
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

    await _firebaseAuthenticationService.firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => log.i('Password is reset'))
        .catchError((error) => log.e(error));
  }
}
