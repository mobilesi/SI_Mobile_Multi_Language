import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_setting/simple_setting.dart';
import 'package:simple_setting/src/setting_data.dart';

extension GetText on String {
  String get tr {
    return _getText();
  }

  String obs({Map<String, dynamic>? params}) {
    if (params == null) {
      return _getText();
    } else {
      return _format(params);
    }
  }

  Future js() async {
    try {
      String data = await rootBundle.loadString(this);
      return jsonDecode(data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String _getText() {
    try {
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
    } catch (e) {
      return this;
    }
  }

  String _format(Map<String, dynamic> params) {
    String text = _getText();
    try {
      if (params.isEmpty) {
        return text;
      }
      for (var element in params.keys) {
        text = text.replaceAll(":$element", params[element].toString());
      }
      return text;
    } catch (e) {
      return text;
    }
  }
}

extension GetWidget on Widget {
  Widget get provider {
    return SettingProvider(
      child: this,
    );
  }
}

extension GetTextWidget on Text {
  Widget obs({Map<String, dynamic>? params}) {
    return SettingWidget(builder: (_, __, ___) {
      return Text(data!.obs(params: params),
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior);
    });
  }
}
