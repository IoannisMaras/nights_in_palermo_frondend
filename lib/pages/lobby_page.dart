import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/second');
            //   },
            //   child: const Text('Go to second page'),
            // ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
