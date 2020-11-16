import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:emusic/service/socket_service.dart';

class SocketServiceImpl implements SocketService {
  Socket _socket;
  String _host;
  int _port;

  @override
  void sendImage(Uint8List image, Function(Uint8List) onData) {
    _socket.listen((data) => onData(data), onDone: () => _socket.destroy());
    _socket.add(image);
    _socket.close();
  }

  @override
  Future<void> setConnection(String host, int port) async {
    _socket = await Socket.connect(host, port);
  }

  @override
  String get host => _host;

  @override
  int get port => _port;
}
