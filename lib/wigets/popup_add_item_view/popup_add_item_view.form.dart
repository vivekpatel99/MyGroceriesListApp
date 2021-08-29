// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String ItemnameValueKey = 'itemname';
const String QuantityValueKey = 'quantity';
const String PriceValueKey = 'price';

mixin $PopupAddItemView on StatelessWidget {
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final FocusNode itemnameFocusNode = FocusNode();
  final FocusNode quantityFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    itemnameController.addListener(() => _updateFormData(model));
    quantityController.addListener(() => _updateFormData(model));
    priceController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            ItemnameValueKey: itemnameController.text,
            QuantityValueKey: quantityController.text,
            PriceValueKey: priceController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    itemnameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get itemnameValue => this.formValueMap[ItemnameValueKey];
  String? get quantityValue => this.formValueMap[QuantityValueKey];
  String? get priceValue => this.formValueMap[PriceValueKey];

  bool get hasItemname => this.formValueMap.containsKey(ItemnameValueKey);
  bool get hasQuantity => this.formValueMap.containsKey(QuantityValueKey);
  bool get hasPrice => this.formValueMap.containsKey(PriceValueKey);
}

extension Methods on FormViewModel {}
