import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/night_state_stepper.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
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
          if (game.story_teller != null) {
            //IS STORY TELLER
            if (game.players[game.story_teller as int].username == username) {
              return Selector<NightStateStepperProvider, int>(
                  builder: (context, step, child) {
                    switch (step) {
                      case 0:
                        return NightStep0(game: game);
                      case 1:
                        return NightStep1(game: game);
                      case 3:
                        return Column(
                          children: [],
                        );
                      default:
                        return const Center(child: Text('Error'));
                    }

                    // return Column(
                    //   children: [
                    //     const Text(
                    //       'It is Nighttime',
                    //       style: TextStyle(fontSize: 30),
                    //     ),
                    //     //add an image here
                    //     const SizedBox(height: 20),
                    //     const Text(
                    //       'Please close your eyes',
                    //       style: TextStyle(fontSize: 20),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     Container(
                    //       height: 300,
                    //       decoration: const BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage("assets/images/night_state.jpg"),
                    //           fit: BoxFit.cover,
                    //         ),
                    //         borderRadius: BorderRadius.all(Radius.circular(20)),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     Expanded(
                    //       flex: 4,
                    //       child: ListView.builder(
                    //         itemCount: players.length,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           final List<String> votersForThisPlayer = players
                    //               .where(
                    //                   (player) => player.is_alive && player.vote == index)
                    //               .map((player) => player.username)
                    //               .toList();
                    //           final int totalVotes = players
                    //               .where(
                    //                   (player) => player.is_alive && player.vote != null)
                    //               .length
                    //               .toInt();
                    //           // Calculate percentage
                    //           double percentage = totalVotes > 0
                    //               ? (votersForThisPlayer.length / totalVotes * 100)
                    //                   .roundToDouble()
                    //               : 0.0;

                    //           // Determine if it's a sole majority
                    //           bool isSoleMajority = percentage > 50;
                    //           final Player myplayer = players
                    //               .firstWhere((player) => player.username == username);
                    //           final int? myVote = myplayer.vote;

                    //           return ListTile(
                    //             tileColor: myVote == index
                    //                 ? colorScheme.secondary.withOpacity(0.3)
                    //                 : (players[index].is_alive
                    //                     ? colorScheme.background
                    //                     : colorScheme.onSurface.withOpacity(0.2)),
                    //             leading: Text('Suspect: ${index + 1}'),
                    //             title: Row(children: [
                    //               Text(players[index].username),
                    //               const SizedBox(width: 8),
                    //               Text(
                    //                 '(${percentage.toStringAsFixed(1)}%)',
                    //                 style: TextStyle(
                    //                   color: isSoleMajority ? Colors.redAccent : null,
                    //                   fontWeight: isSoleMajority ? FontWeight.bold : null,
                    //                 ),
                    //               ),
                    //             ]),
                    //             subtitle: votersForThisPlayer.isNotEmpty
                    //                 ? Text('Voted by: ${votersForThisPlayer.join(', ')}')
                    //                 : null,
                    //             enabled: players[index].is_alive,
                    //             trailing: Checkbox(
                    //               value: myVote == index,
                    //               onChanged: players[index].is_alive
                    //                   ? (bool? newValue) {
                    //                       Provider.of<WebSocketNotifier>(context,
                    //                               listen: false)
                    //                           .sendVote(index);
                    //                     }
                    //                   : null,
                    //             ),
                    //             onTap: players[index].is_alive
                    //                 ? () {
                    //                     //send a message to websocket
                    //                     Provider.of<WebSocketNotifier>(context,
                    //                             listen: false)
                    //                         .sendVote(index);
                    //                   }
                    //                 : null,
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // );
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

class NightStep0 extends StatelessWidget {
  final GameState game;
  const NightStep0({
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Night falls on Palermo",
            style: TextStyle(fontSize: 32),
          ),
          Text("Everyone has to close their eyes..."),
        ],
      )),
      //button to go the next step
      ElevatedButton(
        onPressed: () {
          Provider.of<NightStateStepperProvider>(context, listen: false)
              .nextStep(game, null);
        },
        child: const Text('Next Step'),
      ),
    ]);
  }
}

class NightStep1 extends StatelessWidget {
  final GameState game;
  const NightStep1({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int? death_index;
    List<Player> alive_players =
        game.players.where((player) => player.is_alive).toList();

    return Column(
      children: [
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
        const SizedBox(height: 20),
        Expanded(
          flex: 4,
          child: ListView.builder(
            itemCount: alive_players.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  tileColor: death_index == index
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                      : Theme.of(context).colorScheme.background,
                  leading: Text('Option: ${index + 1}'),
                  title: Text(alive_players[index].username),
                  subtitle: index == death_index
                      ? const Text('This player is chosen to die by the Mafia')
                      : null,
                  //enabled: players[index].is_alive,
                  trailing: Checkbox(
                      value: death_index == index,
                      onChanged: (bool? v) {
                        if (v == true) {
                          death_index = index;
                        } else {
                          death_index = null;
                        }
                      }),
                  onTap: () {
                    if (death_index == index) {
                      death_index = null;
                    } else {
                      death_index = index;
                    }
                  });
            },
          ),
        ),
        ElevatedButton(
          onPressed: death_index != null
              ? () {
                  Provider.of<NightStateStepperProvider>(context, listen: false)
                      .nextStep(game, death_index);
                }
              : null,
          child: const Text('Next Step'),
        ),
      ],
    );
  }
}
