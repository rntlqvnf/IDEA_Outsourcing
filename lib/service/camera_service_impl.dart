import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
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
    final String albumnName = 'idea';
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/img_${_timestamp()}.jpg';

    await _controller.takePicture(filePath);
    if (await GallerySaver.saveImage(filePath, albumName: albumnName)) {
      return filePath;
    } else {
      return Future.error(CameraException('-1', '사진 저장 실패'));
    }
  }

  @override
  Future<int> toggleCamera() async {
    _currentIndex == 0 ? _currentIndex = 1 : _currentIndex = 0;
    await _onNewCameraSelected();
    return _currentIndex;
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
