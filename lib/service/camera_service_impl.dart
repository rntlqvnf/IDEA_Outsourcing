import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:python_app/service/camera_service.dart';

class CameraServiceImpl extends CameraService {
  CameraController _controller;
  List<CameraDescription> _cameras;
  int _currentIndex = 0;
  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  CameraServiceImpl() {
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((value) {
      _cameras = value;
      _onNewCameraSelected();
    });
  }

  @override
  CameraController get controller => _controller;

  @override
  Future<String> takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${_timestamp()}.jpg';

    await _controller.takePicture(filePath);
    return filePath;
  }

  @override
  void toggleCamera() {
    _currentIndex == 0 ? _currentIndex = 1 : _currentIndex = 0;
    _onNewCameraSelected();
  }

  Future<void> _onNewCameraSelected() async {
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(
      _cameras[_currentIndex],
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }
}
