import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';

// TODO Beautification needed
// TODO filter firebase error and dispaly it on page
// TODO add more checks on user input
// TODO add forget password
class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  // Testfield inputs
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Sign In'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Sign Up'),
                  // style: ButtonStyle(
                  //     foregroundColor: MaterialStateProperty.all(Colors.black),
                  //     ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Placeholder(
                        fallbackHeight: 200.0,
                        fallbackWidth: 20.0,
                      ),
                      kSizedBox,
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFormInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (_enteredEmail) =>
                            _enteredEmail!.isEmpty ? 'Enter an Email' : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      kSizedBox,
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: kTextFormInputDecoration.copyWith(
                          hintText: 'Password',
                        ),
                        validator: (_enteredPassword) =>
                            _enteredPassword!.length < 3
                                ? 'Enter  a password with 6+ chars long'
                                : null,
                        onChanged: (_enteredPassword) {
                          setState(() {
                            password = _enteredPassword;
                          });
                        },
                      ),
                      kSizedBox,
                      ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              final dynamic _result =
                                  await _auth.signInWithEmailAndPassord(
                                      email: email, password: password);
                              if (_result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                          icon: const Icon(CupertinoIcons.signature),
                          label: const Text('Sign In')),
                      kSizedBox,
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          );
  }
}
