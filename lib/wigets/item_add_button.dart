import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? myGroceryList =
        Provider.of<Map<String, dynamic>?>(context);

    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const SizedBox();
            });
      },
      child: const Icon(CupertinoIcons.add),
    );
  }
}
