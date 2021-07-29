import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';

class AddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUPAddItemWindow();
            });
      },
      child: const Icon(CupertinoIcons.add),
    );
  }
}
