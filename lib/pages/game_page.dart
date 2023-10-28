import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nights_in_palermo/providers/username_provider.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:nights_in_palermo/services/bottom_sheet_services.dart';
import 'package:nights_in_palermo/services/dialog_services.dart';
import 'package:nights_in_palermo/widgets/game_page/day_state.dart';
import 'package:nights_in_palermo/widgets/game_page/night_state.dart';
import 'package:provider/provider.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    context.read<WebSocketNotifier>().onStateChangeCallback =
        (type, state, message) {
      if (type == 'disconnected') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
          BottomSheetServices.showErrorBottomSheet(
              context, "Got Disconnected from the server");
        });
      } else if (type == 'game_state_change') {
        if (state == 'Day') {
          DialogServices.showInfoDialog(context, message);
        } else if (state == 'Night') {
          DialogServices.showInfoDialog(context, message);
        }
      }
    };
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
              DialogServices.exitGame(context);
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
          child: Selector<WebSocketNotifier, String>(
              builder: (context, state, child) {
                print('STATE HAS BEEN CHANGE TO $state');
                if (state == "Day") {
                  return DayState(
                    username: username,
                    colorScheme: colorScheme,
                  );
                } else {
                  return NightState(
                      username: username, colorScheme: colorScheme);
                }
              },
              selector: (context, counterModel) =>
                  counterModel.gameState.state)),
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
