import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';

import '../../contants/globals.dart';
import '../../service/camera_service.dart';
import '../base_store.dart';

part 'camera_store.g.dart';

class CameraStore = _CameraStore with _$CameraStore;

abstract class _CameraStore with Store, BaseStore {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------

  // services:------------------------------------------------------------------
  CameraService cameraService = locator<CameraService>();

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  @computed
  double get aspectRatio => cameraService.controller.value.aspectRatio;

  @computed
  get controller => cameraService.controller;

  // actions:-------------------------------------------------------------------
  @action
  void toggleCamera() {
    if (loading) return;
    loading = true;
    cameraService.toggleCamera().then((_) => loading = false).catchError(
        (e) => error('카메라 전환에 실패했습니다'),
        test: (e) => e is CameraException);
  }

  @action
  Future<Uint8List> takePicture() async {
    final path = await cameraService.takePicture().catchError(
        (e) => error('에러: ${e.code}\n${e.description}'),
        test: (e) => e is CameraException);

    File file = File(path);
    return file.readAsBytesSync();
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
