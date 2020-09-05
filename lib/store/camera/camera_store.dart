import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
import 'package:python_app/contants/globals.dart';
import 'package:python_app/service/camera_service.dart';
import 'package:python_app/store/base_store.dart';

part 'camera_store.g.dart';

class CameraStore = _CameraStore with _$CameraStore;

abstract class _CameraStore extends BaseStore with Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------

  // services:------------------------------------------------------------------
  CameraService cameraService = locator<CameraService>();

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  @observable
  String filePath = '';

  @computed
  double get aspectRatio => cameraService.controller.value.aspectRatio;

  @computed
  get controller => cameraService.controller;

  // actions:-------------------------------------------------------------------
  @action
  void toggleCamera() {
    try {
      cameraService.toggleCamera();
    } on CameraException catch (e) {
      error('에러: ${e.code}\n${e.description}');
    }
  }

  @action
  void takePicture() {
    cameraService.takePicture().catchError(
        (e) => error('에러: ${e.code}\n${e.description}'),
        test: (e) => e is CameraException);
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
