import 'package:mobx/mobx.dart';
import 'package:python_app/contants/globals.dart';
import 'package:python_app/service/flush_service.dart';

part 'success_store.g.dart';

class SuccessStore = _SuccessStore with _$SuccessStore;

abstract class _SuccessStore with Store {
  // disposers
  List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _SuccessStore() {
    _disposers = [
      reaction((_) => success, showAndReset),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String successMessage = '';

  @observable
  bool success = false;

  // actions:-------------------------------------------------------------------
  @action
  void showAndReset(bool value) {
    if (value) {
      locator<FlushService>().successToast(successMessage);
      successMessage = '';
      success = false;
    }
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
