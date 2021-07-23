import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/pages/bought_page.dart';
import 'package:my_grocery_list/pages/buy_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Buy",
              ),
              Tab(
                text: "Bought",
              ),
              // Tab(
              //   text: "Inventory",
              // )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BuyPage(), BoughtPage(),
            //  InventoryPage(),
          ],
        ),
        floatingActionButton: AddItemButton(),
      ),
    );
  }
}

class AddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUPAddItemWindow();
            });
      },
      child: Icon(CupertinoIcons.shopping_cart),
    );
  }
}

class PopUPAddItemWindow extends StatefulWidget {
  const PopUPAddItemWindow({Key? key}) : super(key: key);

  @override
  _PopUPAddItemWindowState createState() => _PopUPAddItemWindowState();
}

class _PopUPAddItemWindowState extends State<PopUPAddItemWindow> {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
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
            TextFormField(
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
                            print(_catagoryList[index].catagoryName);
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
                  onPressed: () {},
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
