import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_setting/src/cubit/base_state.dart';
import 'package:simple_setting/src/cubit/setting_cubit.dart';
import 'package:simple_setting/src/setting_data.dart';
import 'package:simple_setting/src/setting_type.dart';

class SettingProvider extends StatelessWidget {
  final Widget child;

  const SettingProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(create: (_) => SettingCubit(), child: child,);
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
    return BlocListener<SettingCubit, BaseState>(listener: (_, state) {
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
    }, child: widget.builder(language, mode, vision),);
  }
}
