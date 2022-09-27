# FlutterCrisp

FlutterCrisp is a flutter package that wraps the crisp websdk in flutter which exposes most methods in flutter.
## Android Setup
FlutterCrisp requires a minSdkVersion to 17
```dart

defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.testfluttercrisp"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration.
        minSdkVersion 17
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
 
```

## Installation
Add to pubspec.yaml file
```dart
 fluttercrisp:
    git:
      url: https://github.com/RaheemBureyII/fluttercrisp.git
      ref: de52f5348ff7878ec6677d37e1949256e1623005 # branch name
```

## Usage

```dart

import 'package:flutter/material.dart';
import 'package:fluttercrisp/fluttercrisp.dart';
void main()async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //webid can be acquired from the script tag provided by crisp 
      //website is subjective , you can use a blank page you hosted personally , or any website that isnt a big platform like twitter or facebook , or a website that already has crisp hosted on it like "crisp.chat"
      home:  ChatWidget(website: "https://merchant.getgift.me/",backgroundColor: Colors.blue,webid: "1fe61c88-a23f-40f2-aa2b-1e4a554edcde",onLoad: (){
        print("loaded");
      },onAgentMessage: (){
        print("agent message");
      },),
    );
  }
}

```
## Parameters
### webid 
 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
