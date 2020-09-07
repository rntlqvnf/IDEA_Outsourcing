// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CameraStore on _CameraStore, Store {
  Computed<double> _$aspectRatioComputed;

  @override
  double get aspectRatio =>
      (_$aspectRatioComputed ??= Computed<double>(() => super.aspectRatio,
              name: '_CameraStore.aspectRatio'))
          .value;
  Computed<dynamic> _$controllerComputed;

  @override
  dynamic get controller =>
      (_$controllerComputed ??= Computed<dynamic>(() => super.controller,
              name: '_CameraStore.controller'))
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
  void takePicture() {
    final _$actionInfo = _$_CameraStoreActionController.startAction(
        name: '_CameraStore.takePicture');
    try {
      return super.takePicture();
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
aspectRatio: ${aspectRatio},
controller: ${controller}
    ''';
  }
}
