import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return StreamProvider<Map<String, dynamic>?>.value(
      value:
          DatabaseService(uid: _auth.auth.currentUser?.uid).streamMyGroceryList,
      initialData: {},
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    PopupMenuButton<int>(
                      onSelected: (item) =>
                          onSelected(context: context, item: item),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: const [
                              Icon(Icons.cleaning_services_rounded),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Erase All'),
                            ],
                          ),
                        ),
                      ],
                    )
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
                drawer: MyDrawer(),
                body: TabBarView(
                  children: [
                    BuyPage(), BoughtPage(),
                    //  InventoryPage(),
                  ],
                ),
                floatingActionButton: const AddItemButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '€ 2.99',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }

  void onSelected({required BuildContext context, required int item}) {
    final String? userId = _auth.auth.currentUser?.uid;
    final DatabaseService databaseService = DatabaseService(uid: userId);

    switch (item) {
      case 0:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete All Data!!'),
                content: const Text('Are you sure to delete?'),
                actions: [
                  AlertDialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                      databaseService.deletedItemCollection();
                      databaseService.initDatabaseSetup();
                    },
                    child: const Text('Yes'),
                  ),
                  AlertDialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            });
        break;
      default:
    }
  }
}
