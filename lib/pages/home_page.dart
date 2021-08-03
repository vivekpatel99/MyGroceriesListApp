import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/item_model.dart';
import 'package:my_grocery_list/pages/bought_page.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/wigets/item_add_button.dart';
import 'package:my_grocery_list/wigets/mydrawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyGroceryList>.value(
      value:
          DatabaseService(uid: _auth.auth.currentUser?.uid).streamMyGroceryList,
      initialData: MyGroceryList(),
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
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
            drawer: MyDrawer(),
            body: TabBarView(
              children: [
                BuyPage(), BoughtPage(),
                //  InventoryPage(),
              ],
            ),
            floatingActionButton: AddItemButton(),
          ),
        ),
      ),
    );
  }
}
