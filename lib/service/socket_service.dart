import 'dart:async';
import 'dart:typed_data';

abstract class SocketService {
  String get host;
  int get port;
  Future<void> setConnection(String host, int port);
  void sendImage(Uint8List image, Function(Uint8List) onData);
}
