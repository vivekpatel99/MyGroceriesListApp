import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/catagory_item_model.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/loading.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:my_grocery_list/wigets/item_card_list_tile.dart';
import 'package:provider/provider.dart';

//utANom4HpGWmDKSh4hHEjM0AvLV2

class BuyPage extends StatelessWidget {
  final _catagoryList = CatagoryItemModel.catagoryItemList;
  final log = logger(BuyPage);

  @override
  Widget build(BuildContext context) {
    try {
      final myGroceryList = Provider.of<Map<String, dynamic>?>(context);
      return SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: myGroceryList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final String catagory =
                      myGroceryList?.keys.elementAt(index) as String;
                  final itemsListLen =
                      myGroceryList?.values.elementAt(index)?.length as int;

                  final items = myGroceryList?.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          catagory,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (itemsListLen == 0)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('No item'),
                          )
                        else
                          Flexible(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: itemsListLen,
                                itemBuilder: (BuildContext context, int idx) {
                                  final itemName =
                                      items.elementAt(idx)[kName] as String;
                                  final toBuy =
                                      items.elementAt(idx)[kToBuy] as bool;

                                  final item =
                                      myGroceryList?.values.elementAt(idx);
                                  log.i('ItemName $itemName & toBuy $toBuy');
                                  return ItemCardListTile(
                                    name: itemName,
                                    tobuy: toBuy,
                                  );
                                }),
                          ),
                        kDivider,
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
    } catch (error) {
      log.e('$error');
      log.i('returning to Loading page');
      return const Loading();
    }
  }
}
