import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';

// TODO Beautification needed
// TODO add number only password in sign in and up pages
// TODO filter firebase error and dispaly it on page
// TODO add more checks on user input
class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.toggleView,
  }) : super(key: key);
  final Function toggleView;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  // Testfield inputs
  String _email = '';
  String _password = '';
  String _error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : SafeArea(
            child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Sign Up',
                  style: TextStyle(color: Colors.deepPurpleAccent)),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Sign In'),
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
                            _email = value;
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
                            _enteredPassword!.length < 6
                                ? 'Enter  a password with 6+ chars long'
                                : null,
                        onChanged: (_enteredPassword) {
                          setState(() {
                            _password = _enteredPassword;
                          });
                        },
                      ),
                      kSizedBox,
                      ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurpleAccent,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              final dynamic result =
                                  await _auth.signupWithEmailAndPassword(
                                      email: _email, password: _password);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  _error = 'Please supply a valid email';
                                });
                              }
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.signature,
                          ),
                          label: const Text('Sign Up')),
                      kSizedBox,
                      Text(
                        _error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          ));
  }
}
