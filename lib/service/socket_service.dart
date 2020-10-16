import 'dart:async';
import 'dart:typed_data';

abstract class SocketService {
  StreamSubscription<Uint8List> get receivedImage;
  String get host;
  int get port;
  Future<void> setConnection(String host, int port);
  void sendImage(Uint8List image);
}
