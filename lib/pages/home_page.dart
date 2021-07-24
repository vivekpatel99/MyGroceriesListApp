import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/bought_page.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/wigets/item_add_button.dart';

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
