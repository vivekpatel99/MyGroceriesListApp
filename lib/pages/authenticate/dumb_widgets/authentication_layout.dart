import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/styles.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/ui_helpers.dart';

/// Reference from https://www.youtube.com/watch?v=Y-JawJ4m6Fg&ab_channel=FilledStacks

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? mainButtonTitle;
  final Widget? form;

  // only Visible on create account -> set to true or false to set it
  final bool showTermsText;

  final VoidCallback? onMainButtonTapped;
  final VoidCallback? onCreateAccountTapped;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onBackPressed;
  final String? validationMessage;
  final bool busy;

  const AuthenticationLayout({
    Key? key,
    this.title,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.validationMessage,
    this.showTermsText = false,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          if (onBackPressed == null) kVerticalSpaceLarge,
          if (onBackPressed == null) kVerticalSpaceRegular,
          if (onBackPressed != null)
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              onPressed: onBackPressed,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          Text(
            title!,
            style: const TextStyle(fontSize: 34),
          ),
          kVerticalSpaceSmall,
          // in Design subtitle text does not go beyond 70% hence SizedBox is there
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: screenWidthPercentage(context, percentage: 0.7),
              child: Text(
                subtitle!,
                style: ktsMediumGreyBodyText,
              ),
            ),
          ),
          kVerticalSpaceRegular,
          form!,
          kVerticalSpaceRegular,
          // onForgetPassword textButton only appier if it supply as argument
          if (onForgotPassword != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onForgotPassword,
                child: Text(
                  'Forget Password?',
                  style: ktsMediumGreyBodyText.copyWith(
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          kVerticalSpaceRegular,
          if (validationMessage != null)
            Text(
              validationMessage!,
              style:
                  const TextStyle(color: Colors.red, fontSize: kBodyTextSize),
            ),
          if (validationMessage != null) kVerticalSpaceRegular,
          GestureDetector(
            onTap: onMainButtonTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(8)),
              child: busy
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      mainButtonTitle!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
            ),
          ),
          kVerticalSpaceRegular,
          if (onCreateAccountTapped != null)
            GestureDetector(
              onTap: onCreateAccountTapped,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Don't have an account?"),
                  kHorizontalSpaceTiny,
                  Text(
                    'Create an account',
                    style: TextStyle(color: kcPrimaryColor),
                  )
                ],
              ),
            ),
          if (showTermsText)
            const Text(
              'By signing up you agree to our terms, conditions and privacy policy',
              style: ktsMediumGreyBodyText,
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}
