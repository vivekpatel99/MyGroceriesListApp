import 'package:flutter/material.dart';
import 'package:my_grocery_list/shared/dimensions.dart';

// Text Styles

// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
TextStyle heading1Style = TextStyle(
  fontSize: Dimensions.fontSize34,
  fontWeight: FontWeight.w400,
);

TextStyle heading2Style = TextStyle(
  fontSize: Dimensions.fontSize28,
  fontWeight: FontWeight.w600,
);

TextStyle heading3Style = TextStyle(
  fontSize: Dimensions.fontSize24,
  fontWeight: FontWeight.w600,
);

const TextStyle headlineStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

TextStyle bodyStyle = TextStyle(
  fontSize: Dimensions.fontSize16,
  fontWeight: FontWeight.w400,
);

TextStyle subheadingStyle = TextStyle(
  fontSize: Dimensions.fontSize20,
  fontWeight: FontWeight.w400,
);

TextStyle captionStyle = TextStyle(
  fontSize: Dimensions.fontSize12,
  fontWeight: FontWeight.w400,
);
TextStyle itemNameStyle = TextStyle(
  fontSize: Dimensions.fontSize14,
  fontWeight: FontWeight.w400,
);

TextStyle popupSubtitleStyle = TextStyle(
    fontSize: Dimensions.fontSize15,
    fontWeight: FontWeight.w400,
    color: Colors.grey);

TextStyle validationMsgRedStyle =
    TextStyle(color: Colors.red, fontSize: Dimensions.fontSize12);

TextStyle addupdateButtonStyle = TextStyle(
    //color: Theme.of(context).colorScheme.secondary,
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSize16);

TextStyle kDrawerManuTextStyle = TextStyle(fontSize: Dimensions.fontSize18);
