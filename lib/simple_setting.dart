library simple_setting;

import 'package:simple_setting/src/constant.dart';
import 'package:simple_setting/src/setting_data.dart';
import 'package:simple_setting/src/setting_type.dart';
export 'package:simple_setting/src/setting_data.dart';
export 'package:simple_setting/src/setting_provider.dart';
export 'src/extension.dart';

class SimpleSetting {
  static init(
      {languageData = const {}, modeData = const {}, visionData = const {}, Map<String, dynamic> langMap = const {}}) {
    SettingData.lang = languageData;
    SettingData.mode = modeData;
    SettingData.vision = visionData;
    SettingData.langMap = langMap;
  }

  static changeLanguage(languageData) {
    SettingData.lang = languageData;
    Constant.controller.add(SettingType.language);
  }

  static changeMode(modeData) {
    SettingData.mode = modeData;
    Constant.controller.add(SettingType.mode);
  }

  static changeVision(visionData) {
    SettingData.vision = visionData;
    Constant.controller.add(SettingType.vision);
  }
}
