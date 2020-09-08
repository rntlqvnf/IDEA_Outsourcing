import 'package:mobx/mobx.dart';
import 'package:python_app/store/error/error_store.dart';
import 'package:python_app/store/success/success_store.dart';

mixin BaseStore {
  // other stores:--------------------------------------------------------------
  final ErrorStore _errorStore = ErrorStore();
  final SuccessStore _successStore = SuccessStore();

  // disposers:-----------------------------------------------------------------

  // constructor:---------------------------------------------------------------

  // store variables:-----------------------------------------------------------

  // other variables:-----------------------------------------------------------
  List<Function> _successCallback = List();
  List<Function> _errorCallback = List();

  // dispose:-------------------------------------------------------------------
  dispose() {
    _errorStore.dispose();
    _successStore.dispose();
  }

  // functions:-----------------------------------------------------------------
  set successCallback(List<Function> f) => _successCallback.addAll(f);
  set errorCallback(List<Function> f) => _errorCallback.addAll(f);

  void error(String message) {
    _errorStore.errorMessage = message;
    _errorStore.error = true;
    _errorCallback.forEach((f) => f.call());
  }

  void success(String message) {
    _successStore.successMessage = message;
    _successStore.success = true;
    _successCallback.forEach((f) => f.call());
  }
}
