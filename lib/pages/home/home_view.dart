import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/home/home_viewmodel.dart';
import 'package:my_grocery_list/pages/tabs/bought_tab_view.dart';
import 'package:my_grocery_list/pages/tabs/buy_tab_view.dart';
import 'package:my_grocery_list/pages/total_price/total_price_view.dart';
import 'package:stacked/stacked.dart';

// duration 20:34
//TODO Setup floating button and with AddCatagoryButton
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final log = getLogger('HomeView');
  @override
  Widget build(BuildContext context) {
    log.d('---------------------------- HomeView ----------------------------');
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Center(child: Text('My Groceries List')),
                    actions: [
                      // PopupMenuButton<int>(
                      //   onSelected: (item) =>
                      //       // onSelected(context: context, item: item),
                      //   itemBuilder: (context) => [
                      //     PopupMenuItem(
                      //       value: 0,
                      //       child: Column(
                      //         children: [
                      //           Row(
                      //             children: const [
                      //               Icon(Icons.cleaning_services_rounded),
                      //               SizedBox(
                      //                 width: 15,
                      //               ),
                      //               Text('Erase All'),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
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
                  // drawer: MyDrawer(),
                  body: TabBarView(
                    children: [
                      BuyTabView(),
                      BoughtTabView(),
                    ],
                  ),
                  resizeToAvoidBottomInset: false,
                  // floatingActionButton: const AddCatagoryButton(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
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
                        TotalPriceView(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
