import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/bought_page.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/wigets/item_add_button.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(CupertinoIcons.person),
                label: const Text('Sign Out'))
          ],
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
