import 'package:mobx/mobx.dart';
import 'package:python_app/store/base_store.dart';

part 'editor_store.g.dart';

class EditorStore = _EditorStore with _$EditorStore;

abstract class _EditorStore with BaseStore, Store {}
