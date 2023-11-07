// import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class WebSocketNotifier extends ChangeNotifier {
  WebSocket? _webSocket;
  bool isConnected = false;
  String latestMessage = "No message received.";
  GameState gameState = GameState("lobby", [], null);
  Function(String, String, dynamic)? onStateChangeCallback;

  Future<bool> connect(String url) async {
    await Future.delayed(const Duration(seconds: 1));
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

    return isConnected;
  }

  void _handleMessage(dynamic message) {
    Map<String, dynamic> jsonObject = jsonDecode(message.toString());
    // print(message.toString());
    if (jsonObject['type'] == 'player_change') {
      gameState.players = [];
      for (var player in jsonObject['all_players']) {
        gameState.players.add(Player(player['channel_name'], player['username'],
            player['role'], player['is_alive'], player['vote']));
      }
    } else if (jsonObject['type'] == 'game_state_change') {
      gameState.story_teller = jsonObject['story_teller'];
      gameState.state = jsonObject['state'];
      gameState.players = [];
      for (var player in jsonObject['all_players']) {
        gameState.players.add(Player(player['channel_name'], player['username'],
            player['role'], player['is_alive'], player['vote']));
      }
      onStateChangeCallback!(
          jsonObject['type'], jsonObject['state'], jsonObject['message']);
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
    //int? code = _webSocket!.closeCode;
    if (isConnected == false) {
      notifyListeners();
      return;
    }
    onStateChangeCallback!('disconnected', '', {});
    isConnected = false;
    notifyListeners();
  }

  void _handleError(dynamic error) {
    print("WebSocket error: $error");

    isConnected = false;
    notifyListeners();
  }

  void sendMessage(Object message) {
    if (isConnected) {
      _webSocket!.add(jsonEncode(message));
    }
  }

  void disconnect() {
    isConnected = false;
    _webSocket?.close();

    notifyListeners();
  }

  void startGame() {
    sendMessage({"type": "start_game", "message": ""});
  }

  void sendVote(int vote) {
    sendMessage({"type": "vote_player", "message": vote});
  }

  void endVoting() {
    sendMessage({"type": "end_voting", "message": ""});
  }

  void endNight(int index) {
    sendMessage({"type": "end_night", "message": index});
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
  int? story_teller;

  GameState(this.state, this.players, this.story_teller);
}

class Player {
  // ignore: non_constant_identifier_names
  String channel_name;
  String username;
  String? role;
  // ignore: non_constant_identifier_names
  bool is_alive;
  int? vote;

  Player(this.channel_name, this.username, this.role, this.is_alive, this.vote);
}
