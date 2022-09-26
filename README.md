# FlutterCrisp

FlutterCrisp is a flutter package that wraps the crisp websdk in flutter which exposes most methods in flutter.

## Usage

```dart
//webid is the only required parameter which is can found in the script tag youre provided in crisp in the html section
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
      
      home:  ChatWidget(website: "https://merchant.getgift.me/",backgroundColor: Colors.blue,webid: "1fe61c88-a23f-40f2-aa2b-1e4a554edcde",onLoad: (){
        print("loaded");
      },onAgentMessage: (){
        print("agent message");
      },),
    );
  }
}

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
