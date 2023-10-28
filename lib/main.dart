import 'package:flutter/material.dart';
import 'package:nights_in_palermo/pages/game_page.dart';
import 'package:nights_in_palermo/pages/home_page.dart';
import 'package:nights_in_palermo/pages/lobby_page.dart';
import 'package:nights_in_palermo/providers/night_state_stepper.dart';
import 'package:nights_in_palermo/providers/username_provider.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WebSocketNotifier()),
      ChangeNotifierProvider(create: (context) => UsernameProvider()),
      ChangeNotifierProvider(create: (context) => NightStateStepperProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: 'YsabeauOffice',
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.redAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/lobby': (context) => const LobbyPage(),
        '/game': (context) => const GamePage(),
      },
      home: const HomePage(),
    );
  }
}
