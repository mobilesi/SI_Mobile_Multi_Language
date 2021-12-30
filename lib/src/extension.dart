import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_setting/simple_setting.dart';
import 'package:simple_setting/src/setting_data.dart';

extension GetText on String {
  String get tr {
    try{
      List<String> listKey = split(".");
      if (listKey.length == 1) {
        return SettingData.lang[this] ?? this;
      }
      dynamic valueNest;
      valueNest = SettingData.lang[listKey[0]];
      for (int i = 1; i < listKey.length; i++) {
        valueNest = valueNest[listKey[i]];
      }
      return valueNest ?? this;
    }catch(e){
      return this;
    }
  }
}

extension GetWidget on Widget {
  Widget get obs {
    return SettingWidget(builder: (_, __, ___) {
      debugPrint(jsonEncode(SettingData.lang));
      return this;
    });
  }

  Widget get provider {
    return SettingProvider(child: this,);
  }
}
