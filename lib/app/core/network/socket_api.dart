import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketApi {
  static WebSocketChannel? _channel;
  static bool _connected = false;

  static final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  /// Stream to listen to incoming messages
  static Stream<String> get messageStream => _messageController.stream;

  /// Initialize WebSocket using token
  static void init(String token) {
    if (_connected) return;

    final uri = Uri.parse(
        "ws://148.230.92.132:8001/ws/asc/update_chat_messages/?token=$token");

    try {
      _channel = WebSocketChannel.connect(uri);
      _connected = true;

      _channel!.stream.listen(
        (data) {
          debugPrint('Socket Received: $data');
          _messageController.add(data); // Broadcast to listeners
        },
        onError: (error) {
          debugPrint('Socket error: $error');
          _connected = false;
        },
        onDone: () {
          debugPrint('Socket closed');
          _connected = false;
        },
      );
    } catch (e) {
      debugPrint('Failed to connect to socket: $e');
    }
  }

  /// Send message through WebSocket
  static void emit(Map<String, dynamic> message) {
    if (_connected && _channel != null) {
      final encoded = jsonEncode(message);
      _channel!.sink.add(encoded);
    }
  }

  /// Close connection
  static void disconnect() {
    if (_connected && _channel != null) {
      _channel!.sink.close();
      _connected = false;
    }
  }
}
