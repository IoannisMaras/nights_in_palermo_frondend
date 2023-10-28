import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';
import 'package:provider/provider.dart';

class DayState extends StatelessWidget {
  const DayState({
    super.key,
    required this.username,
    required this.colorScheme,
  });

  final String username;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Selector<WebSocketNotifier, List<Player>>(
        builder: (context, players, child) {
          List<Player> alive_players =
              players.where((player) => player.is_alive).toList();
          return Column(
            children: [
              const Text(
                'It is Daytime',
                style: TextStyle(fontSize: 30),
              ),
              //add an image here
              const SizedBox(height: 20),
              const Text(
                'Who do you suspect?',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/vote2.jpg"),
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
                    final List<String> votersForThisPlayer = alive_players
                        .where(
                            (player) => player.is_alive && player.vote == index)
                        .map((player) => player.username)
                        .toList();
                    final int totalVotes = alive_players
                        .where(
                            (player) => player.is_alive && player.vote != null)
                        .length
                        .toInt();
                    // Calculate percentage
                    double percentage = totalVotes > 0
                        ? (votersForThisPlayer.length / totalVotes * 100)
                            .roundToDouble()
                        : 0.0;

                    // Determine if it's a sole majority
                    bool isSoleMajority = percentage > 50;
                    final Player myplayer = players
                        .firstWhere((player) => player.username == username);
                    final int? myVote = myplayer.vote;

                    return ListTile(
                      tileColor: myVote == index
                          ? colorScheme.secondary.withOpacity(0.3)
                          : (alive_players[index].is_alive
                              ? colorScheme.background
                              : colorScheme.onSurface.withOpacity(0.2)),
                      leading: Text('Suspect: ${index + 1}'),
                      title: Row(children: [
                        Text(alive_players[index].username),
                        const SizedBox(width: 8),
                        Text(
                          '(${percentage.toStringAsFixed(1)}%)',
                          style: TextStyle(
                            color: isSoleMajority ? Colors.redAccent : null,
                            fontWeight: isSoleMajority ? FontWeight.bold : null,
                          ),
                        ),
                      ]),
                      subtitle: votersForThisPlayer.isNotEmpty
                          ? Text('Voted by: ${votersForThisPlayer.join(', ')}')
                          : null,
                      enabled: alive_players[index].is_alive &&
                          alive_players[index].username != username,
                      trailing: Checkbox(
                        value: myVote == index,
                        onChanged: alive_players[index].is_alive
                            ? (bool? newValue) {
                                Provider.of<WebSocketNotifier>(context,
                                        listen: false)
                                    .sendVote(index);
                              }
                            : null,
                      ),
                      onTap: alive_players[index].is_alive
                          ? () {
                              //send a message to websocket
                              Provider.of<WebSocketNotifier>(context,
                                      listen: false)
                                  .sendVote(index);
                            }
                          : null,
                    );
                  },
                ),
              ),
              Selector<WebSocketNotifier, int?>(
                  builder: (context, storyTellerIndex, child) {
                    bool allVoted = true;
                    for (var player in players) {
                      if (player.vote == null) {
                        allVoted = false;
                        break;
                      }
                    }
                    if (!allVoted) {
                      return const SizedBox(height: 0);
                    }
                    if (storyTellerIndex == null) {
                      if (players[0].username == username) {
                        return ElevatedButton(
                          onPressed: () {
                            //check if all player.vote is not null

                            Provider.of<WebSocketNotifier>(context,
                                    listen: false)
                                .endVoting();
                          },
                          child: const Text(
                            'Finish Voting',
                            style: TextStyle(fontSize: 32),
                          ),
                        );
                      } else {
                        return const SizedBox(height: 0);
                      }
                    } else if (players[storyTellerIndex].username == username) {
                      return ElevatedButton(
                        onPressed: () {
                          Provider.of<WebSocketNotifier>(context, listen: false)
                              .endVoting();
                        },
                        child: const Text(
                          'Finish Voting',
                          style: TextStyle(fontSize: 32),
                        ),
                      );
                    } else {
                      return const SizedBox(height: 0);
                    }
                  },
                  selector: (context, counterModel) =>
                      counterModel.gameState.story_teller),
            ],
          );
        },
        selector: (context, counterModel) => counterModel.gameState.players);
  }
}
