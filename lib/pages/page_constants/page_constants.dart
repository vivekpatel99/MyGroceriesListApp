import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

Container secondaryBackground({required MainAxisAlignment mainAxisAlignment}) {
  return Container(
    color: Colors.red,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: const [
          Icon(Icons.delete),
          Text(
            'Move to Trash',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}
