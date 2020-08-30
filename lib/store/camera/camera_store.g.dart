// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CameraStore on _CameraStore, Store {
  Computed<CameraDescription> _$currentCameraComputed;

  @override
  CameraDescription get currentCamera => (_$currentCameraComputed ??=
          Computed<CameraDescription>(() => super.currentCamera,
              name: '_CameraStore.currentCamera'))
      .value;

  final _$loadingAtom = Atom(name: '_CameraStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$camerasAtom = Atom(name: '_CameraStore.cameras');

  @override
  List<CameraDescription> get cameras {
    _$camerasAtom.reportRead();
    return super.cameras;
  }

  @override
  set cameras(List<CameraDescription> value) {
    _$camerasAtom.reportWrite(value, super.cameras, () {
      super.cameras = value;
    });
  }

  final _$controllerAtom = Atom(name: '_CameraStore.controller');

  @override
  CameraController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(CameraController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  final _$currentIndexAtom = Atom(name: '_CameraStore.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$onNewCameraSelectedAsyncAction =
      AsyncAction('_CameraStore.onNewCameraSelected');

  @override
  Future<void> onNewCameraSelected() {
    return _$onNewCameraSelectedAsyncAction
        .run(() => super.onNewCameraSelected());
  }

  final _$takePictureAsyncAction = AsyncAction('_CameraStore.takePicture');

  @override
  Future<void> takePicture() {
    return _$takePictureAsyncAction.run(() => super.takePicture());
  }

  final _$_CameraStoreActionController = ActionController(name: '_CameraStore');

  @override
  void toggleCamera() {
    final _$actionInfo = _$_CameraStoreActionController.startAction(
        name: '_CameraStore.toggleCamera');
    try {
      return super.toggleCamera();
    } finally {
      _$_CameraStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_CameraStoreActionController.startAction(
        name: '_CameraStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_CameraStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
cameras: ${cameras},
controller: ${controller},
currentIndex: ${currentIndex},
currentCamera: ${currentCamera}
    ''';
  }
}
