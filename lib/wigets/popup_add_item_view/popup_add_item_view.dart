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

    return ViewModelBuilder<PopupAddItemViewModel>.nonReactive(
      builder: (context, model, child) => AlertDialog(
        scrollable: true,
        title: Column(
          children: [
            Text(catagoryName),
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
                  onChanged: model.getUserItemName,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Item Name can not be empty';
                    }
                    return null;
                  },
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                    hintText: 'Enter Item Name',
                    labelText: 'Item Name',
                    errorText: model.validationMessage,
                  ),
                ),
                kSizedBox,
                TextFormField(
                  controller: quantityController,
                  onChanged: model.getItemQuantity,
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                    hintText: 'Enter Total Quantity',
                    labelText: 'Quantity',
                  ),
                ),
                kSizedBox,
                TextFormField(
                  controller: priceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: model.getItemPrice,
                  validator: (String? value) {
                    final String _value = value ?? '';
                    try {
                      num.tryParse(_value);
                      return null;
                    } on Exception catch (_) {
                      return 'Price must be a number';
                    }
                  },
                  decoration: kAddItemPopupTextFormInputDecoration.copyWith(
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
                        print('############################################');
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

// class PopUPAddItemWindow extends StatefulWidget {
//   final Map<String, dynamic> myGroceryList;
//   final bool onBuyPage;
//   final String catagoryName;
//   final String itemName;
//   final String quantity;
//   final num price;
//   const PopUPAddItemWindow({
//     Key? key,
//     required this.myGroceryList,
//     required this.onBuyPage,
//     required this.catagoryName,
//     this.itemName = '',
//     this.quantity = '',
//     this.price = 0.00,
//   }) : super(key: key);

//   @override
//   _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
// }

// class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
//   // final List<CatagoryItem> _catagoryList = CatagoryItemModel.catagoryItemList;

//   bool _validate = false;
//   bool _validatePrice = false;
//   bool _addItemTextStatus = false;
//   final GlobalKey<FormState> _popUpAddItemformKey = GlobalKey<FormState>();
//   final TextEditingController _itemNametextFieldController =
//       TextEditingController();
//   final TextEditingController _priceTextFieldController =
//       TextEditingController();
//   final TextEditingController _quantityTextFieldController =
//       TextEditingController();
//   final log = logger(PopUPAddItemWindow);

//   @override
//   void dispose() {
//     _itemNametextFieldController.dispose();
//     _priceTextFieldController.dispose();
//     _quantityTextFieldController.dispose();
//     super.dispose();
//   }

//   void _addItemButtonVerification(BuildContext context) {
//     // Check if Item Name field is empty then show message
//     if (_popUpAddItemformKey.currentState!.validate()) {
//       setState(() {
//         _addItemTextStatus = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final user = Provider.of<UserModel?>(context);
//     final catagoryItemsViewModel = locator<CatagoryItemsViewModel>();
//     // final CatagoryItemsViewModel catagoryItemsViewModel =
//     //     Provider.of<CatagoryItemsViewModel>(context);

//     final List<dynamic> itemList =
//         widget.myGroceryList[widget.catagoryName] as List<dynamic>;

//     final catagoryItems = itemList
//         .map<Catagory>(
//             (json) => Catagory.fromJson(json as Map<String, dynamic>))
//         .toList();
//     final int foundItemIndex =
//         catagoryItems.indexWhere((element) => element.name == widget.itemName);

//     String _itemName = '';
//     String _quantity = '';
//     double _price = 0.0;

//     // final String userId = user?.uid ?? '';
//     _itemNametextFieldController.text = widget.itemName;
//     _priceTextFieldController.text =
//         widget.price == 0.0 ? '' : widget.price.toString();
//     _quantityTextFieldController.text =
//         widget.quantity.isNotEmpty ? widget.quantity : '';

//     return AlertDialog(
//       scrollable: true,
//       title: const Text('Add Item to Buy'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _popUpAddItemformKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _itemNametextFieldController,
//                 onChanged: (String text) {
//                   _itemName = text.capitalize();
//                 },
//                 validator: (String? value) {
//                   if (value!.isEmpty) {
//                     return 'Item Name can not be empty';
//                   }
//                   return null;
//                 },
//                 decoration: kAddItemPopupTextFormInputDecoration.copyWith(
//                   hintText: 'Enter Item Name',
//                   labelText: 'Item Name',
//                 ),
//               ),
//               kSizedBox,
//               TextFormField(
//                 controller: _quantityTextFieldController,
//                 onChanged: (String text) {
//                   _quantity = text.capitalize();
//                 },
//                 decoration: kAddItemPopupTextFormInputDecoration.copyWith(
//                   hintText: 'Enter Total Quantity',
//                   labelText: 'Quantity',
//                 ),
//               ),
//               kSizedBox,
//               TextFormField(
//                 controller: _priceTextFieldController,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
//                 ],
//                 keyboardType: TextInputType.number,
//                 onChanged: (String text) {
//                   try {
//                     final double? _priceTemp =
//                         double.tryParse(_priceTextFieldController.text);
//                     _price = _priceTemp ?? 0.0;
//                     _validatePrice = true;
//                   } on Exception catch (_) {
//                     _validatePrice = false;
//                   }
//                 },
//                 decoration: kAddItemPopupTextFormInputDecoration.copyWith(
//                   prefix: const Text('€'),
//                   hintText: 'Enter Price',
//                   labelText: 'Price',
//                 ),
//               ),
//               kSizedBox,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () async {
//                       _price = _priceTextFieldController.text.isEmpty
//                           ? _price = 0.0
//                           : _price;

//                       _quantity = _quantityTextFieldController.text == '' ||
//                               _quantityTextFieldController.text.isEmpty
//                           ? _quantity = ''
//                           : _quantity;

//                       _addItemButtonVerification(context);

//                       if (_itemName.isNotEmpty ||
//                           _price != 0.0 ||
//                           _quantity.isNotEmpty) {
//                         final Catagory _catagory = Catagory(
//                           name: _itemName.isNotEmpty &&
//                                   widget.itemName != _itemName
//                               ? _itemName
//                               : widget.itemName,
//                           price: _price != 0.0 && widget.price != _price
//                               ? _price
//                               : 0.00,
//                           quantity: _quantity.isNotEmpty &&
//                                   widget.quantity != _quantity
//                               ? _quantity
//                               : widget.quantity,
//                           toBuy: widget.onBuyPage,
//                         );

//                         if (foundItemIndex != -1) {
//                           catagoryItems[foundItemIndex] = _catagory;
//                           log.i(
//                               'foundItemIndex: $foundItemIndex, catagoryName: ${widget.catagoryName}, ItemName: $_itemName, Quantity: $_quantity, price €$_price');
//                         } else {
//                           catagoryItems.add(_catagory);
//                           log.i(
//                               'New index added for ItemName: $_itemName, Quantity: $_quantity, price €$_price');
//                         }
//                         await catagoryItemsViewModel.addUpdateItem(
//                           catagoryName: widget.catagoryName,
//                           catagoryItemList: catagoryItems,
//                         );
//                       }
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Add',
//                       style: TextStyle(
//                           color: Theme.of(context).accentColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
