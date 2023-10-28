import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';

class DialogServices {
  static void exitGame(BuildContext context) async {
    bool areYouSure = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Game'),
        content: const Text('Are you sure you want to exit this game?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (areYouSure == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        //dicsconnect from the websocket
        context.read<WebSocketNotifier>().disconnect();
      });
    }
  }

  static void showInfoDialog(BuildContext context, dynamic message,
      {String buttonText = "OK"}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message['title']),
        content: Text(message['message']),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
