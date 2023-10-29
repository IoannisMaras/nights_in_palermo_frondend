import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/night_state_stepper.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';

class NightStep1 extends StatefulWidget {
  final GameState game;

  const NightStep1({
    required this.game,
    Key? key,
  }) : super(key: key);

  @override
  NightStep1State createState() => NightStep1State();
}

class NightStep1State extends State<NightStep1> {
  int? deathIndex;
  List<Player> alivePlayers = [];

  @override
  void initState() {
    super.initState();
    alivePlayers =
        widget.game.players.where((player) => player.is_alive).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'It is Nighttime',
          style: TextStyle(fontSize: 30),
        ),
        // Add an image here
        const SizedBox(height: 20),
        const Text(
          'Chose a player to die',
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
        const SizedBox(height: 20),
        Expanded(
          flex: 4,
          child: ListView.builder(
            itemCount: alivePlayers.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                tileColor: deathIndex == index
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                    : Theme.of(context).colorScheme.background,
                leading: Text('Option: ${index + 1}'),
                title: Text(alivePlayers[index].username),
                subtitle: index == deathIndex
                    ? const Text('This player is chosen to die by the Mafia')
                    : null,
                trailing: Checkbox(
                  value: deathIndex == index,
                  onChanged: (bool? v) {
                    setState(() {
                      if (v == true) {
                        deathIndex = index;
                      } else {
                        deathIndex = null;
                      }
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    if (deathIndex == index) {
                      deathIndex = null;
                    } else {
                      deathIndex = index;
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: deathIndex != null
              ? () {
                  Provider.of<NightStateStepperProvider>(context, listen: false)
                      .nextStep(widget.game, deathIndex);
                }
              : null,
          child: const Text('Next Step'),
        ),
      ],
    );
  }
}
