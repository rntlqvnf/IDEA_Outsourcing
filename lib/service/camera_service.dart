import 'package:camera/camera.dart';
import 'package:python_app/service/initializable_service.dart';

abstract class CameraService with InitializableService {
  CameraController get controller;

  Future<String> takePicture();
  Future<int> toggleCamera();
}
