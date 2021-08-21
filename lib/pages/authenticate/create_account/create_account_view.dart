import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/create_account/create_account_view.form.dart';
import 'package:my_grocery_list/pages/authenticate/create_account/create_account_viewmodel.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/authentication_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'create_account_view.form.dart';
import 'create_account_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class CreateAccountView extends StatelessWidget with $CreateAccountView {
  CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onMainButtonTapped: model.saveData,
          onBackPressed: model.navigationBack,
          validationMessage: model.validationMessage,
          title: 'Create Account',
          subtitle: 'Enter your name, email and password for sign up',
          mainButtonTitle: 'SIGN UP',
          form: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                controller: fullNameController,
              ),
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
          showTermsText: true,
        ),
      ),
      viewModelBuilder: () => CreateAccountViewModel(),
    );
  }
}
