import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/my_extensions.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:provider/provider.dart';

class PopUPAddItemWindow extends StatefulWidget {
  final Map<String, dynamic> myGroceryList;
  final bool onBuyPage;
  final String catagoryName;
  String itemName;
  String quantity;
  num price;
  PopUPAddItemWindow({
    Key? key,
    required this.myGroceryList,
    required this.onBuyPage,
    required this.catagoryName,
    this.itemName = '',
    this.quantity = '',
    this.price = 0.00,
  }) : super(key: key);

  @override
  _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
}

class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
  // final List<CatagoryItem> _catagoryList = CatagoryItemModel.catagoryItemList;

  bool _validate = false;
  bool _validatePrice = false;
  bool _addItemTextStatus = false;
  final GlobalKey<FormState> _popUpAddItemformKey = GlobalKey<FormState>();
  final TextEditingController _itemNametextFieldController =
      TextEditingController();
  final TextEditingController _priceTextFieldController =
      TextEditingController();
  final TextEditingController _quantityTextFieldController =
      TextEditingController();
  final log = logger(PopUPAddItemWindow);

  @override
  void dispose() {
    _itemNametextFieldController.dispose();
    _priceTextFieldController.dispose();
    _quantityTextFieldController.dispose();
    super.dispose();
  }

  void _addItemButtonVerification(BuildContext context) {
    // Check if Item Name field is empty then show message
    if (_popUpAddItemformKey.currentState!.validate()) {
      setState(() {
        _addItemTextStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final List<dynamic> itemList =
        widget.myGroceryList[widget.catagoryName] as List<dynamic>;

    final catagoryItems = itemList
        .map<Catagory>(
            (json) => Catagory.fromJson(json as Map<String, dynamic>))
        .toList();
    final int foundItemIndex =
        catagoryItems.indexWhere((element) => element.name == widget.itemName);

    String _itemName = '';
    String _quantity = '';
    double _price = 0.0;

    final String userId = user?.uid ?? '';
    _itemNametextFieldController.text = widget.itemName;
    _priceTextFieldController.text =
        widget.price == 0.0 ? '' : widget.price.toString();
    _quantityTextFieldController.text =
        widget.quantity.isNotEmpty ? widget.quantity : '';

    return AlertDialog(
      scrollable: true,
      title: const Text('Add Item to Buy'),
      content: SingleChildScrollView(
        child: Form(
          key: _popUpAddItemformKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _itemNametextFieldController,
                onChanged: (String text) {
                  _itemName = text.capitalize();
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Item Name can not be empty';
                  }
                  return null;
                },
                decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                  hintText: 'Enter Item Name',
                  labelText: 'Item Name',
                ),
              ),
              kSizedBox,
              TextFormField(
                controller: _quantityTextFieldController,
                onChanged: (String text) {
                  _quantity = text.capitalize();
                },
                decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                  hintText: 'Enter Total Quantity',
                  labelText: 'Quantity',
                ),
              ),
              kSizedBox,
              TextFormField(
                controller: _priceTextFieldController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                ],
                keyboardType: TextInputType.number,
                onChanged: (String text) {
                  try {
                    final double? _priceTemp =
                        double.tryParse(_priceTextFieldController.text);
                    _price = _priceTemp ?? 0.0;
                    _validatePrice = true;
                  } on Exception catch (_) {
                    _validatePrice = false;
                  }
                },
                decoration: kAddItemPopupTextFormInputDecoration.copyWith(
                  prefix: const Text('€'),
                  hintText: 'Enter Price',
                  labelText: 'Price',
                ),
              ),
              kSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      _price = _priceTextFieldController.text.isEmpty
                          ? _price = 0.0
                          : _price;

                      _quantity = _quantityTextFieldController.text == '' ||
                              _quantityTextFieldController.text.isEmpty
                          ? _quantity = ' '
                          : _quantity;

                      _addItemButtonVerification(context);

                      if (_itemName.isNotEmpty ||
                          _price != 0.0 ||
                          _quantity.isNotEmpty) {
                        final Catagory _catagory = Catagory(
                          name: _itemName.isNotEmpty &&
                                  widget.itemName != _itemName
                              ? _itemName
                              : widget.itemName,
                          price: _price != 0.0 && widget.price != _price
                              ? _price
                              : 0.00,
                          quantity: _quantity.isNotEmpty &&
                                  widget.quantity != _quantity
                              ? _quantity
                              : widget.quantity,
                          toBuy: widget.onBuyPage,
                        );

                        if (foundItemIndex != -1) {
                          catagoryItems[foundItemIndex] = _catagory;
                          log.i(
                              'foundItemIndex: $foundItemIndex, catagoryName: ${widget.catagoryName}, ItemName: $_itemName, Quantity: $_quantity, price €$_price');
                        } else {
                          catagoryItems.add(_catagory);
                          log.i(
                              'New index added for ItemName: $_itemName, Quantity: $_quantity, price €$_price');
                        }
                        await DatabaseService(uid: userId).addUpdateItem(
                          catagoryName: widget.catagoryName,
                          catagoryItemList: catagoryItems,
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}




// const InputDecoration(
//                   hintText: 'Enter Item Name',
//                   labelText: 'Item Name',
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.deepPurpleAccent),
//                   ),
//                 )
