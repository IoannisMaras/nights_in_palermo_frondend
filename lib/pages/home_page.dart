import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nights_in_palermo/pages/lobby_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void joinGame() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context)
                .requestFocus(FocusNode()), // Close keyboard on tap outside
            child: Center(
              child: SingleChildScrollView(
                child: GiffyDialog.image(
                  Image.asset('assets/images/join_game.jfif'),
                  title: const Text(
                    'Joining a game',
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Paste Room ID here:',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Room ID',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Or Scan QR code  '),
                            Icon(Icons.photo_camera),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'CANCEL'),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('JOIN GAME'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: const Text(
          "P A L E R M O  N I G H T S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //textfeild to add name
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const SizedBox(height: 20.0),
            //add a container wiht curved edges covering the full width of the screen
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/homepage2.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            const Text(
              'Welcome to Palermo Nights!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Please enter your name:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            //switch to deside if you want to create or join a game
            const SizedBox(height: 20.0),
            const Text(
              'Do you want to create or join a game?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      joinGame();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LobbyPage(
                      //               gameId: null,
                      //             )));
                    },
                    child: const Text('Join a game'),
                  ),
                ),
                Expanded(child: Container()),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LobbyPage(
                                    gameId: null,
                                  )));
                    },
                    child: const Text('Create a new game'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
