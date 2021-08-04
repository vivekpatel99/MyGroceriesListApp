import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    //* Testfield inputs
    String email = '';
    String error = '';

    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Sign In',
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFormInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (_enteredEmail) =>
                            _enteredEmail!.isEmpty ? 'Enter an Email' : null,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
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
                            loading = true;
                            final dynamic _result =
                                await _auth.resetPassword(email: email);
                            if (_result == null) {
                              error = 'Wrong email adress';
                              loading = false;
                            }
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(CupertinoIcons.signature),
                        label: const Text(
                          'Reset Password',
                        )),
                    kSizedBox,
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
