// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ErrorStore on _ErrorStore, Store {
  final _$errorMessageAtom = Atom(name: '_ErrorStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$errorAtom = Atom(name: '_ErrorStore.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_ErrorStoreActionController = ActionController(name: '_ErrorStore');

  @override
  void showAndReset(bool value) {
    final _$actionInfo = _$_ErrorStoreActionController.startAction(
        name: '_ErrorStore.showAndReset');
    try {
      return super.showAndReset(value);
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo =
        _$_ErrorStoreActionController.startAction(name: '_ErrorStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
error: ${error}
    ''';
  }
}
