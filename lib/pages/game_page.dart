import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nights_in_palermo/providers/username_provider.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:nights_in_palermo/widgets/game_page/day_state.dart';
import 'package:provider/provider.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  void exitGame(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<UsernameProvider>(context, listen: false).username;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb),
            tooltip: 'Help',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GiffyDialog.image(
                    Image.network(
                      "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      'Image Animation',
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'This is a image animation dialog box. This library helps you easily create fancy giffy dialog.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'CANCEL'),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Go back',
            onPressed: () {
              exitGame(context);
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          "P L A Y I N G",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DayState(username: username, colorScheme: colorScheme),
      ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: const [
          Icons.supervised_user_circle,
          Icons.pan_tool,
          Icons.note_add,
        ],
        secondaryIconsText: const [
          "Show Role",
          "Use Ability",
          "Kepp Notes",
          // "cut",
        ],
        secondaryIconsOnPress: [
          () => {},
          () => {},
          () => {},
        ],
        // secondaryBackgroundColor: Colors.black,
        // secondaryForegroundColor: Colors.grey,
        // primaryBackgroundColor: Colors.grey[900],
        // primaryForegroundColor: Colors.grey[100],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
