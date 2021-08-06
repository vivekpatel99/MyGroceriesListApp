import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/wigets/popup_add_item_window.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    Key? key,
  }) : super(key: key);
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
      child: const Icon(CupertinoIcons.add),
    );
  }
}
