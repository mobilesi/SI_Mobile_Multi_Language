import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_setting/src/cubit/base_state.dart';
import 'package:simple_setting/src/setting_data.dart';
import 'package:simple_setting/src/setting_type.dart';

class SettingCubit extends Cubit<BaseState> {
  SettingCubit() : super(InitState());

  changeLanguage() {
    emit(LoadedState(data: SettingData.lang, type: SettingType.language));
  }

  changeMode() {
    emit(LoadedState(data: SettingData.mode, type: SettingType.mode));
  }

  changeVision() {
    emit(LoadedState(data: SettingData.vision, type: SettingType.vision));
  }
}