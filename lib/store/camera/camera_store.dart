import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:python_app/store/error/error_store.dart';
import 'package:python_app/store/success/success_store.dart';

part 'camera_store.g.dart';

class CameraStore = _CameraStore with _$CameraStore;

abstract class _CameraStore with Store {
  // other stores:--------------------------------------------------------------
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  _CameraStore() {
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((value) => cameras = value);
  }

  // store variables:-----------------------------------------------------------
  @observable
  List<CameraDescription> cameras;

  @observable
  int currentIndex = 0;

  @computed
  CameraDescription get currentCamera => cameras[currentIndex];

  // actions:-------------------------------------------------------------------
  @action
  void toggleCamera() {
    currentIndex == 0 ? currentIndex = 1 : currentIndex = 0;
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    errorStore.dispose();
    successStore.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
  void updateOnError(String message) {
    errorStore.errorMessage = message;
    errorStore.error = true;
  }

  void updateOnSuccess(String message) {
    successStore.successMessage = message;
    successStore.success = true;
  }
}
