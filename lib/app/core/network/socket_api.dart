import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketApi {
  static WebSocketChannel? _channel;
  static bool _connected = false;
  static StreamSubscription<dynamic>? _subscription;

  static final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  /// Stream to listen to incoming messages
  static Stream<String> get messageStream => _messageController.stream;

  /// Initialize WebSocket using token
  static void init(String token) {
    if (_connected) return;
    disconnect();

    final uri = Uri.parse(ApiEndpoints.chatSocketUrl(token: token));

    try {
      _channel = WebSocketChannel.connect(uri);
      _connected = true;

      _subscription = _channel!.stream.listen(
        (data) {
          debugPrint('Socket Received: $data');
          _messageController.add(data.toString()); // Broadcast to listeners
        },
        onError: (Object error, StackTrace st) {
          debugPrint('Socket error: $error');
          _connected = false;
          // Let listeners (controllers/UI) react to socket failures.
          _messageController.addError(error, st);
        },
        onDone: () {
          debugPrint('Socket closed');
          _connected = false;
          // Inform listeners so they can reconnect / update UI.
          _messageController.addError(
            StateError('Socket closed'),
            StackTrace.current,
          );
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('Failed to connect to socket: $e');
      _connected = false;
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
    _subscription?.cancel();
    _subscription = null;

    if (_channel != null) {
      _channel!.sink.close();
    }

    _channel = null;
    _connected = false;
  }
}
