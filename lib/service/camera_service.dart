import 'package:camera/camera.dart';

abstract class CameraService {
  CameraController get controller;

  Future<String> takePicture();
  void toggleCamera();
}
