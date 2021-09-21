import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/authentication_layout.dart';
import 'package:my_grocery_list/pages/authenticate/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onMainButtonTapped: model.saveData,
          onCreateAccountTapped: model.navigateToCreateAccount,
          validationMessage: model.validationMessage,
          title: 'Welcome',
          subtitle: 'Enter your email address to sign in',
          mainButtonTitle: 'SIGN IN',
          form: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordController,
              )
            ],
          ),
          onForgotPassword: () {},
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
