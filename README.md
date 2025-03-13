# 🚀 FlutterCrisp  

**FlutterCrisp** is a Flutter package that seamlessly integrates the **Crisp Web SDK**, providing a bridge to Crisp's powerful live chat features. This package exposes most Crisp methods in Flutter, making it easy to enhance your app's customer support experience.  

---

## 📱 Android Setup  

FlutterCrisp requires `minSdkVersion 17`. Ensure your `android/app/build.gradle` file is updated:  

```gradle
defaultConfig {
    applicationId "com.example.testfluttercrisp"
    minSdkVersion 17
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

---

## 📦 Installation  

Add **FlutterCrisp** to your `pubspec.yaml`:  

```yaml
fluttercrisp:
  git:
    url: https://github.com/RaheemBureyII/fluttercrisp.git
    ref: de52f5348ff7878ec6677d37e1949256e1623005 # branch name
```

---

## 🚀 Quick Start  

```dart
import 'package:flutter/material.dart';
import 'package:fluttercrisp/fluttercrisp.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crisp Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatWidget(
        website: "https://merchant.getgift.me/",
        backgroundColor: Colors.blue,
        webid: "1fe61c88-a23f-40f2-aa2b-1e4a554edcde",
        onLoad: () => print("Crisp Chat Loaded"),
        onAgentMessage: () => print("New Agent Message"),
      ),
    );
  }
}
```

---

## 🔧 Attributes & Configuration  

| Attribute      | Description |
|---------------|-------------|
| **`webid`** | Get from **Crisp Dashboard** → Settings → Website Settings → Integrations → HTML (CRISP_WEBSITE_ID). |
| **`website`** | Injects Crisp chat on a selected website. Choose a personal site or a simple hosted page. Avoid large-scale platforms (e.g., Twitter, Instagram) or sites already using Crisp. |
| **`name`** | Sets the visitor’s name. |
| **`company`** | Assigns a company to the visitor profile. |
| **`email`** | Associates an email with the visitor session. |
| **`phone`** | Links a phone number to the visitor session. |
| **`onAgentMessage`** | Callback triggered when an agent sends a message. |
| **`onLoad`** | Callback executed when Crisp chat fully loads. |
| **`session_data`** | Pushes additional session data. |

---

## 🤝 Contributing  
Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.  

Make sure to update tests as appropriate.  

---

## 📜 License  
[MIT](https://choosealicense.com/licenses/mit/)  
