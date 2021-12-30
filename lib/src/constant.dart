import 'dart:async';

import 'package:simple_setting/src/setting_type.dart';

class Constant {
  static final controller = StreamController<SettingType>.broadcast();
}