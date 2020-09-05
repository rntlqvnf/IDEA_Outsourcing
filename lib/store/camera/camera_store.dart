import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:python_app/store/base_store.dart';

part 'camera_store.g.dart';

class CameraStore = _CameraStore with _$CameraStore;

abstract class _CameraStore extends BaseStore with Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  _CameraStore() {
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((value) {
      cameras = value;
      toggleCamera();
    });
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  @observable
  List<CameraDescription> cameras;

  @observable
  CameraController controller;

  @observable
  int currentIndex = 1;

  @computed
  CameraDescription get currentCamera => cameras[currentIndex];

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  // actions:-------------------------------------------------------------------
  @action
  void toggleCamera() {
    currentIndex == 0 ? currentIndex = 1 : currentIndex = 0;
    onNewCameraSelected();
  }

  @action
  Future<void> onNewCameraSelected() async {
    loading = true;

    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      currentCamera,
      ResolutionPreset.medium,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (controller.value.hasError) {
        error('Camera error ${controller.value.errorDescription}');
      }
    });

    await controller.initialize().catchError(
        (e) => error('Error: ${e.code}\n${e.description}'),
        test: (e) => e is CameraException);

    loading = false;
  }

  @action
  Future<void> takePicture() async {
    if (!controller.value.isInitialized) {
      error('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return;
    }
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      error('Error: ${e.code}\n${e.description}');
    }
    success('$filePath 에 저장 완료되었습니다.');
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    super.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
}
