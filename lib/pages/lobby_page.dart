import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LobbyPage extends StatelessWidget {
  final String? gameId;

  const LobbyPage({Key? key, this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    String finalGameId = gameId ?? uuid.v4();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   String url = "ws://10.0.2.2::8000/ws/game/$finalGameId/Lerex";
    //   print(url);
    //   Provider.of<WebSocketNotifier>(context, listen: false).connect(url);
    // });

    String url = "ws://10.0.2.2:8000/ws/game/$finalGameId/Lerex/";

    // final websocket = context.read<WebSocketNotifier>();

    // Future<bool> isConnected = websocket.connect(url);

    // if (!value.isConnected) {
    //   // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //   Navigator.pop(context);
    //   // });
    // }

    return Scaffold(
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
            onPressed: () {
              // Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GiffyDialog(
                    // Image.network(
                    //   "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // ),
                    giffy: Container(
                      height: 200,
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
          } else if (snapshot.hasError) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Navigator.pop(context);
            // });
            return Container(); // return an empty container if you wish to pop immediately
          } else if (snapshot.hasData && snapshot.data == true) {
            return Selector<WebSocketNotifier, List<Player>>(
                builder: (context, count, child) {
                  return ListView(
                    children: count
                        .map((player) => ListTile(
                              title: Text(player.username),
                              //admin as subtitle if it is the first player
                              subtitle: Text(count[0] == player ? 'admin' : ''),
                            ))
                        .toList(),
                  );
                },
                selector: (context, counterModel) =>
                    counterModel.gameState.players);
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
            return Text("Unknown state");
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
