import 'package:simple_setting/src/setting_type.dart';

abstract class BaseState {
  const BaseState();
}

class InitState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState<T> extends BaseState {
  final T data;
  final SettingType type;

  LoadedState({required this.data, required this.type}) : assert(data != null);
}

class ErrorState<T> extends BaseState {
  final T data;

  ErrorState({required this.data}) : assert(data != null);
}
