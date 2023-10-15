import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:nights_in_palermo/widgets/global/connecting_spinner.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class LobbyPage extends StatelessWidget {
  final String? gameId;

  const LobbyPage({Key? key, this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    String finalGameId = gameId ?? uuid.v4();
    String tempGameId = '6a64fcb0-75a7-4528-a69e-791363aca82c';

    String url = '';
    if (kIsWeb) {
      url = "ws://10.0.2.2:8000/ws/game/$tempGameId/Lerex/";
    } else {
      url = "ws://localhost:8000/ws/game/$tempGameId/Lerex/";
    }

    void showErrorBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'An error occurred!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(' -Please try again later.'),
              ],
            ),
          );
        },
      );
    }

    void exitLobby(BuildContext context) async {
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
        });
      }
    }
    // final websocket = context.read<WebSocketNotifier>();

    // Future<bool> isConnected = websocket.connect(url);

    // if (!value.isConnected) {
    //   // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //   Navigator.pop(context);
    //   // });
    // }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          centerTitle: true,
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
              onPressed: () async {
                // Navigator.pop(context);
                exitLobby(context);
              },
            ),
          ],
          title: const Text(
            "L O B B Y",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<bool>(
          future: context
              .read<WebSocketNotifier>()
              .connect(url), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ConnectingSpinner();
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
                showErrorBottomSheet(context);
              });
              //show a bottom sheet with the error

              return const Center(
                child: Text("Error has occured"),
              );
              // return an empty container if you wish to pop immediately
            } else if (snapshot.hasData && snapshot.data == true) {
              return Selector<WebSocketNotifier, List<Player>>(
                  builder: (context, count, child) {
                    return ListView(
                      children: count
                          .map((player) => ListTile(
                                title: Text(player.username),
                                //admin as subtitle if it is the first player
                                subtitle:
                                    Text(count[0] == player ? 'admin' : ''),
                              ))
                          .toList(),
                    );
                  },
                  selector: (context, counterModel) =>
                      counterModel.gameState.players);
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
                showErrorBottomSheet(context);
              });
              return const Center(child: Text("Unknown state"));
            }
          },
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
