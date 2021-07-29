import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:provider/provider.dart';

class PopUPAddItemWindow extends StatefulWidget {
  const PopUPAddItemWindow({Key? key}) : super(key: key);

  @override
  _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
}

class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
  final List<CatagoryItem> _catagoryList = CatagoryItemModel.catagoryItemList;
  List<ItemModel> dairyProdList = CatagoryItemModel.dairyProdList;
  List<ItemModel> vegetablesList = CatagoryItemModel.vegetablesList;
  List<ItemModel> fruitsList = CatagoryItemModel.fruitsList;
  String _userEnteredItemName = '';
  String _catagoryName = '';
  bool _validate = false;
  int _itemIdx = -1;
  final List<int> _selectedIdx = [];
  bool _addItemTextStatus = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
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
                controller: _textFieldController,
                onChanged: (String text) {
                  _userEnteredItemName = text;
                  // print(_userEnteredItemName);
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
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 300.0,
                width: 400.0,
                child: ListView.builder(
                  itemCount: _catagoryList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          title: Text(_catagoryList[index].catagoryName),
                          value: _catagoryList[index].isCheck,
                          onChanged: (bool? value) {
                            _itemIdx = index;
                            _selectedIdx.add(index);
                            if (_selectedIdx.length > 1) {
                              _catagoryList[_selectedIdx.elementAt(0)].isCheck =
                                  false;
                              _selectedIdx.removeAt(0);
                            }
                            _catagoryList[index].isCheck = value!;
                            _catagoryName = _catagoryList[index].catagoryName;

                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final Catagory _catagory =
                          Catagory(name: _userEnteredItemName);
                      await DatabaseService(uid: userId).addItem(
                        catagoryName: _catagoryName,
                        catagory: _catagory,
                      );
                      _textFieldController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      if (_itemIdx != -1) {
                        _catagoryList[_itemIdx].isCheck = false;
                      }

                      _addItemButtonVerification(context);
                      if (_textFieldController.text.isNotEmpty &&
                          _selectedIdx.isNotEmpty) {
                        // _textFieldController.
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
}
