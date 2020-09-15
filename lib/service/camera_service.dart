import 'package:camera/camera.dart';
import 'package:emusic/service/initializble_service.dart';

abstract class CameraService with InitializableService {
  CameraController get controller;

  Future<String> takePicture();
  Future<int> toggleCamera();
}
