// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CatagoryValueKey = 'catagory';

mixin $AddCatagoryButton on StatelessWidget {
  final TextEditingController catagoryController = TextEditingController();
  final FocusNode catagoryFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    catagoryController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            CatagoryValueKey: catagoryController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    catagoryController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get catagoryValue => this.formValueMap[CatagoryValueKey];

  bool get hasCatagory => this.formValueMap.containsKey(CatagoryValueKey);
}

extension Methods on FormViewModel {}
