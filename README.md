# Simple Setting

[![pub package](https://img.shields.io/pub/v/simple_setting.svg)](https://pub.dev/packages/simple_setting)

A package for internationalizing flutter apps by simple way.

## Usage
To use this plugin, add `simple_setting` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

### Step 0
Import package
```dart
import 'package:simple_setting/simple_setting.dart';
```

### Step 1
Define a class to store language map, ex:
```dart
class Lang {
  static const Map<String, String> vi = {
    "title": "Ví dụ",
  };

  static const Map<String, String> en = {
    "title": "Example",
  };
}
```

### Step 2
Init language info
```dart
SimpleSetting.init(languageData: Lang.vi);
```

### Step 3
Wrap your first widget by `SettingProvider`
```dart
void main() {
  runApp(const SettingProvider(child: MyApp()));
}
```

### Step 4
Catch language setting change by `SettingWidget` and use language by string extension `tr`
```dart
SettingWidget(builder: (_, __, ___) {
  return MyHomePage(title: "title".tr);
}
```

### Step 5
When you want to change language, use this statement
```dart
SimpleSetting.changeLanguage(context, Lang.en);
```

### Note:
If you need automatic change language follow by system language, you can parse `langMap` parameter to `init` function, ex:
```dart
SimpleSetting.init(langMap: {
    "en_US": Lang.en,
    "vi_VN": Lang.vi
});
```

### Full example
```dart
import 'package:flutter/material.dart';
import 'package:simple_setting/simple_setting.dart';

void main() {
  // SimpleSetting.init(langMap: {
  //   "en_US": Lang.en,
  //   "vi_VN": Lang.vi
  // });
  SimpleSetting.init(languageData: Lang.vi);
  runApp(const SettingProvider(child: MyApp()));
}

class Lang {
  static const Map<String, String> vi = {
    "title": "Ví dụ",
  };

  static const Map<String, String> en = {
    "title": "Example",
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingWidget(builder: (language, _, __) {
        return MyHomePage(title: "title".tr);
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // check current lang
          bool isVi = SettingData.lang == Lang.vi;
          SimpleSetting.changeLanguage(context, isVi ? Lang.en : Lang.vi);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```