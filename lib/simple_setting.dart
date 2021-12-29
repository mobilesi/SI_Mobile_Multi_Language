library simple_setting;

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_setting/src/cubit/setting_cubit.dart';
import 'package:simple_setting/src/setting_data.dart';
export 'package:simple_setting/src/setting_data.dart';
export 'package:simple_setting/src/setting_provider.dart';
export 'src/extension.dart';

class SimpleSetting {
  static init(
      {languageData = const {},
      modeData = const {},
      visionData = const {},
      Map<String, dynamic> langMap = const {}}) {
    SettingData.lang = languageData;
    SettingData.mode = modeData;
    SettingData.vision = visionData;
    SettingData.langMap = langMap;
  }

  static changeLanguage(BuildContext context, languageData) {
    SettingData.lang = languageData;
    BlocProvider.of<SettingCubit>(context).changeLanguage();
  }

  static changeMode(BuildContext context, modeData) {
    SettingData.mode = modeData;
    BlocProvider.of<SettingCubit>(context).changeMode();
  }

  static changeVision(BuildContext context, visionData) {
    SettingData.vision = visionData;
    BlocProvider.of<SettingCubit>(context).changeVision();
  }
}
