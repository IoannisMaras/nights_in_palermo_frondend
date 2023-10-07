// import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class WebSocketNotifier extends ChangeNotifier {
  WebSocket? _webSocket;
  bool isConnecting = false;
  bool isConnected = false;
  String latestMessage = "No message received.";

  void connect(String url) async {
    isConnecting = true;
    notifyListeners();

    try {
      _webSocket = await WebSocket.connect(url);
      isConnected = true;
      isConnecting = false;
      // ... (other code)
    } catch (e) {
      isConnecting = false;
      print("Could not connect to WebSocket: $e");
    }

    notifyListeners();
  }

  void _handleMessage(dynamic message) {
    latestMessage = message.toString();
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
