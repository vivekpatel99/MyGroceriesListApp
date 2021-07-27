import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitChasingDots(
        // todo find a way to add dynamically theme color from mythem class
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
