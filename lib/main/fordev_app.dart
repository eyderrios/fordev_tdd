import 'dart:io';

import 'package:flutter/material.dart';

import './android_app.dart';
import './cupertino_app.dart';

class ForDevApp extends StatelessWidget {
  const ForDevApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const IOSApp() : const AndroidApp();
  }
}
