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
  final bool onBuyPage;
  final String catagoryName;
  const PopUPAddItemWindow({
    Key? key,
    required this.onBuyPage,
    required this.catagoryName,
  }) : super(key: key);

  @override
  _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
}

class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
  // final List<CatagoryItem> _catagoryList = CatagoryItemModel.catagoryItemList;

  bool _validate = false;
  int _itemIdx = -1;
  final List<int> _selectedIdx = [];
  final List<String> userChecked = [];
  bool _addItemTextStatus = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
      setState(() {
        _addItemTextStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    String _itemName = '';
    String _quantity = '';
    String _currencySymbol = '';
    double _price = 0.00;
    final String userId = user?.uid ?? '';

    return AlertDialog(
      scrollable: true,
      title: const Text('Add Item to Buy'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                decoration: InputDecoration(
                  hintText: 'Enter Item Name',
                  labelText: 'Item Name',
                  errorText: _validate ? 'Please Enter Item Name' : null,
                ),
              ),
              kSizedBox,
              TextFormField(
                controller: _quantityTextFieldController,
                onChanged: (String text) {
                  _quantity = text.capitalize();
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Total Quantity',
                  labelText: 'Quantity',
                ),
              ),
              kSizedBox,
              TextFormField(
                controller: _priceTextFieldController,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (String text) {
                  _price = double.parse(text);
                },
                decoration: const InputDecoration(
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
                      // await DatabaseService(uid: userId)
                      //     .addCatagory(catagoryName: 'Chatni');
                      _itemNametextFieldController.text.isEmpty
                          ? _validate = true
                          : _validate = false;

                      _priceTextFieldController.text.isEmpty
                          ? _price = 0.00
                          : _price;
                      _quantityTextFieldController.text.isEmpty
                          ? _quantity = 'quantity'
                          : _quantity;
                      _addItemButtonVerification(context);
                      if (_itemNametextFieldController.text.isNotEmpty) {
                        final Catagory _catagory = Catagory(
                            name: _itemName,
                            price: _price,
                            quantity: _quantity,
                            toBuy: widget.onBuyPage);
                        log.i(
                            'catagoryName: ${widget.catagoryName}, ItemName: $_itemName, Quantity: $_quantity, price $_price');
                        await DatabaseService(uid: userId).addItem(
                          catagoryName: widget.catagoryName,
                          catagory: _catagory,
                        );
                        Navigator.pop(context);
                      }
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

  void _onSelected({required bool selected, required String name}) {
    if (selected) {
      setState(() {
        userChecked.add(name);
      });
    } else {
      setState(() {
        userChecked.remove(name);
      });
    }
  }
}

                          // title: Text(_catagoryList[index].catagoryName),
                          // value: _catagoryList[index].isCheck,
                          // onChanged: (bool? value) {
                          //   _itemIdx = index;
                          //   _selectedIdx.add(index);
                          //   if (_selectedIdx.length > 1) {
                          //     _catagoryList[_selectedIdx.elementAt(0)].isCheck =
                          //         false;
                          //     _selectedIdx.removeAt(0);
                          //   }
                          //   _catagoryList[index].isCheck = value!;
                          //   _catagoryName = _catagoryList[index].catagoryName;

                          //   setState(() {});
                          // },
