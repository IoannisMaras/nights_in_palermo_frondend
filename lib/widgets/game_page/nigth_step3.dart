import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/night_state_stepper.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';

class NightStep3 extends StatelessWidget {
  final GameState game;
  const NightStep3({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        'It is Nighttime',
        style: TextStyle(fontSize: 30),
      ),
      //add an image here
      const SizedBox(height: 20),
      const Text(
        'Everything is settled',
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 20),
      Container(
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/night_state.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      const Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "The sun is slowly rising",
            style: TextStyle(fontSize: 32),
          ),
          Text("Tell everyone to open their eyes..."),
        ],
      )),
      //button to go the next step
      ElevatedButton(
        onPressed: () {
          Provider.of<WebSocketNotifier>(context, listen: false).endNight(
              Provider.of<NightStateStepperProvider>(context, listen: false)
                  .step);
        },
        child: const Text('Next Step'),
      ),
    ]);
  }
}
