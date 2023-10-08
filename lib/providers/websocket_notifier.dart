// import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class WebSocketNotifier extends ChangeNotifier {
  WebSocket? _webSocket;
  bool isConnected = false;
  String latestMessage = "No message received.";

  Future<bool> connect(String url) async {
    _webSocket = await WebSocket.connect(url);
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
    latestMessage = message.toString();
    print(latestMessage);
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
