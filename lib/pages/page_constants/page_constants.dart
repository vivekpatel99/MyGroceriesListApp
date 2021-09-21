import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//--------------------------------------------------------------------------------------------
Container dismissibleBackground(
    {required MainAxisAlignment mainAxisAlignment, required String msgText}) {
  return Container(
    color: Colors.deepPurpleAccent,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [Text(msgText)],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------------------
Container secondaryBackground({required MainAxisAlignment mainAxisAlignment}) {
  return Container(
    color: Colors.red,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: const [
          Icon(Icons.delete),
        ],
      ),
    ),
  );
}

//--------------------------------------------------------------------------------------------
bool simpleSnackBar(
    {required BuildContext context,
    required String displayMsg,
    required VoidCallback onPressed}) {
  final SnackBar _snackBar = SnackBar(
    content: Text(displayMsg),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onPressed,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  return true;
}

//--------------------------------------------------------------------------------------------
Map<String, dynamic>? shortedMyGroceryList(
    {@required Map<String, dynamic>? myGroceryList}) {
  late Map<String, dynamic>? sortedMyGroceryList;
  if (myGroceryList != null) {
    return sortedMyGroceryList = Map.fromEntries(myGroceryList.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
  } else {
    return sortedMyGroceryList = {};
  }
}
