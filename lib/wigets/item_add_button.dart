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
    print('######xx ${myGroceryList}');
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dummy(context: context);
            });
      },
      child: const Icon(CupertinoIcons.add),
    );
  }
}

class Dummy extends StatelessWidget {
  final BuildContext context;
  const Dummy({
    Key? key,
    required this.context,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? myGroceryList =
        Provider.of<Map<String, dynamic>?>(context);
    print('dddddddddddddddddddddddddd');
    print(myGroceryList);
    return AlertDialog(
      actions: [],
    );
  }
}
