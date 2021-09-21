import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/ui_helpers.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/wigets/popup_add_item_view/popup_add_item_view.form.dart';
import 'package:my_grocery_list/wigets/popup_add_item_view/popup_add_item_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

const String ksAddItemStr = 'Add Item';
const String ksUpdateitemStr = 'Update Item';
const String ksAddButtonTitle = 'Add';
const String ksUpdateButtonTitle = 'Update';

@FormView(fields: [
  FormTextField(name: 'itemname'),
  FormTextField(name: 'quantity'),
  FormTextField(name: 'price'),
])
class PopupAddItemView extends StatelessWidget with $PopupAddItemView {
  PopupAddItemView({
    Key? key,
    required this.myGroceryList,
    required this.onBuyPage,
    required this.catagoryName,
    required this.addUpdate, // true = add and false = update
    this.itemName = '',
    this.quantity = '',
    this.price = 0.00,
  }) : super(key: key);
  final Map<String, dynamic> myGroceryList;
  final bool onBuyPage;
  final String catagoryName;
  final String itemName;
  final String quantity;
  final num price;
  final bool addUpdate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    itemnameController.text = itemName;
    priceController.text = price == 0.0 ? '' : price.toString();
    quantityController.text = quantity.isNotEmpty ? quantity : '';

    return ViewModelBuilder<PopupAddItemViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => AlertDialog(
        scrollable: true,
        title: Column(
          children: [
            Text(catagoryName),
            kVerticalSpaceSmall,
            Text(
              addUpdate ? ksAddItemStr : ksUpdateitemStr,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: itemnameController,
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                    hintText: 'Enter Item Name',
                    labelText: 'Item Name',
                    errorText: model.validationMessage,
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return model.validationMessage;
                    }
                  },
                ),
                kSizedBox,
                TextField(
                  controller: quantityController,
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                    hintText: 'Enter Total Quantity',
                    labelText: 'Quantity',
                  ),
                ),
                kSizedBox,
                TextField(
                  controller: priceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                    // TODO in Next version add user edit currency symbol
                    prefix: const Text('€'),
                    hintText: 'Enter Price',
                    labelText: 'Price',
                  ),
                ),
                kSizedBox,
                if (model.validationMessage != null)
                  Text(
                    model.validationMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                if (model.validationMessage != null) kVerticalSpaceRegular,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        model.updateUserInputs(
                            addUpdate: addUpdate,
                            catagoryName: catagoryName,
                            itemName: itemName,
                            quantity: quantity,
                            price: price,
                            onBuyPage: onBuyPage);

                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        addUpdate ? ksAddButtonTitle : ksUpdateButtonTitle,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PopupAddItemViewModel(),
    );
  }
}
