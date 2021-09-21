import 'package:flutter/material.dart';

// Horizontal Spacing
const Widget kHorizontalSpaceTiny = SizedBox(width: 5.0);
const Widget kHorizontalSpaceSmall = SizedBox(width: 10.0);
const Widget kHorizontalSpaceRegular = SizedBox(width: 18.0);
const Widget kHorizontalSpaceMedium = SizedBox(width: 25.0);
const Widget kHorizontalSpaceLarge = SizedBox(width: 50.0);

const Widget kVerticalSpaceTiny = SizedBox(height: 5.0);
const Widget kVerticalSpaceSmall = SizedBox(height: 10.0);
const Widget kVerticalSpaceRegular = SizedBox(height: 18.0);
const Widget kVerticalSpaceMedium = SizedBox(height: 25.0);
const Widget kVerticalSpaceLarge = SizedBox(height: 50.0);

// Screen Size helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

// Value of percentage must be between 0 and 1
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
