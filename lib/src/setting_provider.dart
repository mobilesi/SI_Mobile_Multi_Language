import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_setting/simple_setting.dart';
import 'package:simple_setting/src/cubit/base_state.dart';
import 'package:simple_setting/src/cubit/setting_cubit.dart';
import 'package:simple_setting/src/setting_data.dart';
import 'package:simple_setting/src/setting_type.dart';

class SettingProvider extends StatelessWidget {
  final Widget child;

  const SettingProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
        create: (_) => SettingCubit(),
        child: _SettingProvider(
          child: child,
        ));
  }
}

class _SettingProvider extends StatefulWidget {
  final Widget child;

  const _SettingProvider({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingProviderBody();
  }
}

class _SettingProviderBody extends State<_SettingProvider> with WidgetsBindingObserver {
  @override
  void initState() {
    if (SettingData.langMap!.isNotEmpty) {
      WidgetsBinding.instance!.addObserver(this);
      SettingData.lang = SettingData.langMap![Platform.localeName];
    }
    super.initState();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    try {
      if (SettingData.langMap!.isNotEmpty) {
        SimpleSetting.changeLanguage(context, SettingData.langMap![Platform.localeName]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    super.didChangeLocales(locales);
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

  const SettingWidget({Key? key, required this.builder, this.language, this.mode, this.vision}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingWidgetBody();
  }
}

class _SettingWidgetBody extends State<SettingWidget> {
  dynamic language, mode, vision;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingCubit, BaseState>(
      listener: (_, state) {
        if (state is LoadedState) {
          if (state.type == SettingType.language) {
            setState(() {
              language = state.data;
            });
          } else if (state.type == SettingType.mode) {
            setState(() {
              mode = state.data;
            });
          } else if (state.type == SettingType.vision) {
            setState(() {
              vision = state.data;
            });
          } else {
            // todo
          }
        }
      },
      child: widget.builder(language, mode, vision),
    );
  }
}
