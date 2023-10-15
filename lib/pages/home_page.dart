import 'package:flutter/material.dart';
import 'package:nights_in_palermo/pages/lobby_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LobbyPage(
                                    gameId: null,
                                  )));
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
