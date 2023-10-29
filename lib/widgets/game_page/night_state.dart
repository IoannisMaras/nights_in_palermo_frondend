import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/night_state_stepper.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:nights_in_palermo/widgets/game_page/night_step0.dart';
import 'package:nights_in_palermo/widgets/game_page/night_step1.dart';
import 'package:nights_in_palermo/widgets/game_page/nigth_step3.dart';
import 'package:provider/provider.dart';

class NightState extends StatelessWidget {
  const NightState({
    super.key,
    required this.username,
    required this.colorScheme,
  });

  final String username;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Selector<WebSocketNotifier, GameState>(
        builder: (context, game, child) {
          int? storyTellerIndex = game.story_teller;
          if (storyTellerIndex != null) {
            //IS STORY TELLER
            if (game.players[storyTellerIndex].username == username) {
              return Selector<NightStateStepperProvider, int>(
                  builder: (context, step, child) {
                    print(step);
                    switch (step) {
                      case 0:
                        return NightStep0(game: game);
                      case 1:
                        return NightStep1(game: game);
                      case 2:
                        return const Column(
                          children: [],
                        );
                      case 3:
                        return NightStep3(game: game);
                      default:
                        return const Center(child: Text('Error'));
                    }
                  },
                  selector: (context, counterModel) => counterModel.step);
            } else {
              return Column(children: [
                const Text(
                  'It is Nighttime',
                  style: TextStyle(fontSize: 30),
                ),
                //add an image here
                const SizedBox(height: 20),
                const Text(
                  'Please close your eyes',
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
                    child:
                        Center(child: Text("The story teller is in charge...")))
              ]);
            }
          }
          return const Center(child: Text('Error'));
        },
        selector: (context, counterModel) => counterModel.gameState);
  }
}
