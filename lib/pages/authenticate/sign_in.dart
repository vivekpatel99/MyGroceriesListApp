import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/constants.dart';

// TODO Beautification needed

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

  // Testfield inputs
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Sign In'),
          actions: [
            TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Sign up'),
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
                    decoration: kTextFormInputDecoration.copyWith(
                      hintText: 'Password',
                    ),
                    validator: (_enteredPassword) =>
                        _enteredPassword!.length < 3
                            ? 'Enter  a password with 3+ chars long'
                            : null,
                    onChanged: (_enteredPassword) {
                      setState(() {
                        password = _enteredPassword;
                      });
                    },
                  ),
                  kSizedBox,
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('$email $password');
                        }
                      },
                      icon: const Icon(CupertinoIcons.signature),
                      label: const Text('Sign in')),
                  kSizedBox,
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
