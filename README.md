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

* If you use json file, skip `Step 1`

### Step 2
Init language info and wrap your first widget by `SettingProvider`
```dart
void main() {
  SimpleSetting.init(languageData: Lang.vi);
  runApp(const MyApp().provider);
}
// for json
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SimpleSetting.init(languageData: await "path to asset json file".js());
  runApp(const MyApp().provider);
}
```

### Step 3
Catch language setting change by `SettingWidget` and use language by string extension `obs`
```dart
SettingWidget(builder: (_, __, ___) {
  return MyHomePage(title: "title".obs());
}

// or use extension for Text widget
Text("title").obs()
```

### Step 4
When you want to change language, use this statement
```dart
SimpleSetting.changeLanguage(Lang.en);

// for json
SimpleSetting.changeLanguage(await "path to asset json file".js());
```

### Note:
- If you need automatic change language follow by system language, you can parse `langMap` parameter to `init` function, ex:
```dart
SimpleSetting.init(langMap: {
    "en_US": Lang.en,
    "vi_VN": Lang.vi
});
```
- If you need format a string with parameter, you can parse params to `obs` extension
```dart
class Lang {
  static const Map<String, String> vi = {
    "title": "Ví dụ :id",
  };

  static const Map<String, String> en = {
    "title": "Example :id",
  };
}

// and use
Text("title".obs(params: {"id": 1}));

// or
Text("title").obs(params: {"id": 1});

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
  runApp(const MyApp());
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
      home: const MyHomePage(title: "title"),
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
        title: Text(widget.title).obs(),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // check current lang
          bool isVi = SettingData.lang == Lang.vi;
          SimpleSetting.changeLanguage(isVi ? Lang.en : Lang.vi);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```