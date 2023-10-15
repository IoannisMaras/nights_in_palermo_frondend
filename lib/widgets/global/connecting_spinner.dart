import 'package:flutter/material.dart';

class ConnectingSpinner extends StatelessWidget {
  const ConnectingSpinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Text("Connecting to server..."),
        SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              strokeWidth: 15,
            ))
      ],
    ));
  }
}