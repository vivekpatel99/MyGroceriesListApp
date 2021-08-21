import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/pages/bought_page.dart';
import 'package:my_grocery_list/pages/buy_page.dart';
import 'package:my_grocery_list/shared/logging.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:my_grocery_list/wigets/item_add_button.dart';
import 'package:my_grocery_list/wigets/mydrawer.dart';
import 'package:my_grocery_list/wigets/total_price.dart';
import 'package:provider/provider.dart';

//--------------------------------------------------------------------------------------------
class HomePageView extends StatelessWidget {
  final log = logger(HomePageView);

  // CatagoryItemsViewModel catagoryItemsViewModel = CatagoryItemsViewModel();
  @override
  Widget build(BuildContext context) {
    final CatagoryItemsViewModel catagoryItemsViewModel =
        Provider.of<CatagoryItemsViewModel>(context);
    log.d('----------- HomePage rebuild --------------------');

    //----------------------------------------------------------------------------------------
    void onSelected({required BuildContext context, required int item}) {
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
                        catagoryItemsViewModel.deleteAllItems();
                        // databaseService.deletedItemCollection();
                        catagoryItemsViewModel.initDatabaseSetup();
                        // databaseService.initDatabaseSetup();
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

    //----------------------------------------------------------------------------------------
    return StreamProvider<Map<String, dynamic>?>.value(
      value: CatagoryItemsViewModel().streamMyGroceryList,
      //DatabaseService(uid: _auth.auth.currentUser?.uid).streamMyGroceryList,
      initialData: const {},
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    PopupMenuButton<int>(
                      onSelected: (item) =>
                          onSelected(context: context, item: item),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.cleaning_services_rounded),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('Erase All'),
                                ],
                              ),
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
                    BuyPage(),
                    BoughtPage(),
                  ],
                ),
                resizeToAvoidBottomInset: false,
                floatingActionButton: const AddCatagoryButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      TotalPriceTextWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
