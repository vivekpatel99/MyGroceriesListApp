import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';

class PopUPAddItemWindow extends StatefulWidget {
  const PopUPAddItemWindow({Key? key}) : super(key: key);

  @override
  _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
}

class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  late String _userEnteredItemName;
  late String _catagoryName;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Add Item to Buy'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (text) {
                _userEnteredItemName = text;
                // print(_userEnteredItemName);
              },
              decoration: InputDecoration(
                hintText: "Enter Item Name",
                labelText: "Item Name",
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 300.0,
              width: 400.0,
              child: ListView.builder(
                itemCount: _catagoryList.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(_catagoryList[index].catagoryName),
                          value: _catagoryList[index].isCheck,
                          onChanged: (val) {
                            setState(() {});
                            _catagoryList[index].isCheck = val!;
                            _catagoryName = _catagoryList[index].catagoryName;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    print('$_userEnteredItemName -> $_catagoryName');
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
    );
  }
}
