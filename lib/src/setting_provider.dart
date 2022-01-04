import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_setting/simple_setting.dart';
import 'package:simple_setting/src/constant.dart';
import 'package:simple_setting/src/setting_data.dart';
import 'package:simple_setting/src/setting_type.dart';

class SettingProvider extends StatefulWidget {
  final Widget child;

  const SettingProvider({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingProviderBody();
  }
}

class _SettingProviderBody extends State<SettingProvider>
    with WidgetsBindingObserver {
  @override
  void initState() {
    if (SettingData.langMap!.isNotEmpty) {
      WidgetsBinding.instance!.addObserver(this);
      SettingData.lang = SettingData
          .langMap![WidgetsBinding.instance!.window.locale.toString()];
    }
    super.initState();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    try {
      if (SettingData.langMap!.isNotEmpty) {
        SimpleSetting.changeLanguage(SettingData
            .langMap![WidgetsBinding.instance!.window.locale.toString()]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    super.didChangeLocales(locales);
  }

  @override
  void dispose() {
    Constant.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class SettingWidget extends StatefulWidget {
  final Function builder;
  final dynamic language;
  final dynamic mode;
  final dynamic vision;

  const SettingWidget(
      {Key? key, required this.builder, this.language, this.mode, this.vision})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingWidgetBody();
  }
}

class _SettingWidgetBody extends State<SettingWidget> {
  dynamic language, mode, vision;

  late StreamSubscription subscription;

  @override
  void initState() {
    if (widget.language == null) {
      language = SettingData.lang;
    } else {
      language = widget.language;
    }
    if (widget.mode == null) {
      mode = SettingData.mode;
    } else {
      mode = widget.mode;
    }
    if (widget.vision == null) {
      vision = SettingData.vision;
    } else {
      vision = widget.vision;
    }
    subscription = Constant.controller.stream.listen((SettingType type) {
      if (type == SettingType.language) {
        setState(() {
          language = SettingData.lang;
        });
      } else if (type == SettingType.mode) {
        setState(() {
          mode = SettingData.mode;
        });
      } else if (type == SettingType.vision) {
        setState(() {
          vision = SettingData.vision;
        });
      } else {
        // todo
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(language, mode, vision);
  }
}
