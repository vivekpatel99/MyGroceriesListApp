import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/smart_widgets/add_catagory_button.dart';
import 'package:my_grocery_list/pages/smart_widgets/drawer/drawer_widget_view.dart';
import 'package:my_grocery_list/pages/tabs/bought_tab_view.dart';
import 'package:my_grocery_list/pages/tabs/buy_tab_view.dart';
import 'package:my_grocery_list/pages/total_price/total_price_test_widget.dart';
import 'package:my_grocery_list/pages/total_price/total_price_viewmodel.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/dimensions.dart';
import 'package:my_grocery_list/shared/styles.dart';
import 'package:my_grocery_list/viewmodels/catagory_item_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final log = getLogger('HomeView');
  final CatagoryItemsViewModel _catagoryItemsViewModel =
      locator<CatagoryItemsViewModel>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalPriceViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Center(
                        child: Text(
                      kAppTitle,
                      style: heading3Style,
                    )),
                    actions: [
                      PopupMenuButton<int>(
                        onSelected: _onPopupManuButtonSelect,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.cleaning_services_rounded),
                                    SizedBox(
                                      width: Dimensions.sizeBoxWidth15,
                                    ),
                                    const Text('Erase All'),
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
                          text: kTabBuy,
                        ),
                        Tab(
                          text: kTabBought,
                        ),
                      ],
                    ),
                  ),
                  drawer: DrawerWidgetView(),
                  body: TabBarView(
                    children: [
                      BuyTabView(),
                      BoughtTabView(),
                    ],
                  ),
                  resizeToAvoidBottomInset: false,
                  // todo Refactor using dialog
                  floatingActionButton: AddCatagoryButton(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          kTotal,
                          style: subheadingStyle,
                        ),
                        SizedBox(
                          width: Dimensions.sizeBoxWidth40,
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
      ),
      viewModelBuilder: () => TotalPriceViewModel(),
    );
  }

  VoidCallback? _onPopupManuButtonSelect(int itemIdx) {
    switch (itemIdx) {
      case 0:
        _catagoryItemsViewModel.deleteAllItems();
        break;
      default:
    }
  }
}

// class HomeView extends StatelessWidget {
//   HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     log.d('---------------------------- HomeView ----------------------------');
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: SafeArea(
//           child: Builder(
//             builder: (BuildContext context) {
//               return Scaffold(
//                 appBar: AppBar(
//                   title: const Center(child: Text('My Groceries List')),
//                   actions: [
//                     PopupMenuButton<int>(
//                       onSelected: _onPopupManuButtonSelect,
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           value: 0,
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: const [
//                                   Icon(Icons.cleaning_services_rounded),
//                                   SizedBox(
//                                     width: 15,
//                                   ),
//                                   Text('Erase All'),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                   bottom: const TabBar(
//                     tabs: [
//                       Tab(
//                         text: "Buy",
//                       ),
//                       Tab(
//                         text: "Bought",
//                       ),
//                     ],
//                   ),
//                 ),
//                 // drawer: MyDrawer(),
//                 body: TabBarView(
//                   children: [
//                     BuyTabView(),
//                     BoughtTabView(),
//                   ],
//                 ),
//                 resizeToAvoidBottomInset: false,
//                 // todo Refactor using dialog
//                 floatingActionButton: AddCatagoryButton(),
//                 floatingActionButtonLocation:
//                     FloatingActionButtonLocation.centerDocked,
//                 bottomNavigationBar: BottomAppBar(
//                   shape: const CircularNotchedRectangle(),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Text(
//                         'Total',
//                         style: TextStyle(
//                             fontSize: 25.0, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         width: 40,
//                       ),
//                       TotalPriceTextWidget(),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
