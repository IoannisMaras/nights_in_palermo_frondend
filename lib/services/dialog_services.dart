import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

  // static int _countLetters(String text) {
  //   int count = 0;
  //   for (int i = 0; i < text.length; i++) {
  //     count++;
  //   }
  //   print(count);
  //   return count;
  // }

  static void showInfoDialog(BuildContext context, dynamic message,
      {String buttonText = "OK"}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/night_state.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(message['title'],
                    speed: const Duration(milliseconds: 200))
              ],
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
            )
          ],
        ),
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
