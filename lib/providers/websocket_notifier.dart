// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class WebSocketNotifier extends ChangeNotifier {
  WebSocket? _webSocket;
  bool isConnected = false;
  String latestMessage = "No message received.";
  late GameState gameState = GameState("lobby", [], null);

  Future<bool> connect(String url) async {
    print(url);
    _webSocket = await WebSocket.connect(url)
        .timeout(const Duration(seconds: 15), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
    _webSocket!.listen(
      _handleMessage,
      onDone: _handleDone,
      onError: _handleError,
    );
    isConnected = true;

    // ... (other code)

    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    return isConnected;
  }

  void _handleMessage(dynamic message) {
    Map<String, dynamic> jsonObject = jsonDecode(message.toString());
    print(jsonObject);
    print(jsonObject['type']);

    if (jsonObject['type'] == 'player_change') {
      gameState.players = [];
      for (var player in jsonObject['all_players']) {
        gameState.players.add(Player(player['channel_name'], player['username'],
            player['role'], player['is_alive'], player['vote']));
      }
    }
    // if (jsonObject is PlayerChangeEvent) {
    //   print(jsonObject.type);
    // } else {
    //   print("not a player change event");
    // }
    // if (message.type == 'player_change') {
    //   gameState.players = [];
    //   // for (var player in message.all_players) {
    //   //   gameState.players.add(Player(player.channel_name, player.username,
    //   //       player.role, player.is_alive, player.vote));
    //   // }
    // }

    notifyListeners();
  }

  void _handleDone() {
    isConnected = false;
    notifyListeners();
  }

  void _handleError(dynamic error) {
    print("WebSocket error: $error");
    isConnected = false;
    notifyListeners();
  }

  void sendMessage(String message) {
    if (isConnected) {
      _webSocket!.add(jsonEncode({"message": message}));
    }
  }

  void disconnect() {
    _webSocket?.close();
    isConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _webSocket?.close();
    super.dispose();
  }
}

class GameState {
  String state;
  List<Player> players;
  // ignore: non_constant_identifier_names
  String? story_teller;

  GameState(this.state, this.players, this.story_teller);
}

class Player {
  // ignore: non_constant_identifier_names
  String channel_name;
  String username;
  String? role;
  // ignore: non_constant_identifier_names
  bool? is_alive;
  Int? vote;

  Player(this.channel_name, this.username, this.role, this.is_alive, this.vote);
}
