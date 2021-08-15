import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/sign_in.dart';
import 'package:my_grocery_list/pages/authenticate/sign_up.dart';
import 'package:my_grocery_list/shared/logging.dart';

//--------------------------------------------------------------------------------------------
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  final log = logger(Authenticate);
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      log.i('SignIn page opens');
      return SignIn(toggleView: toggleView);
    } else {
      log.i('SignUp page opens');
      return SignUp(toggleView: toggleView);
    }
  }
}
