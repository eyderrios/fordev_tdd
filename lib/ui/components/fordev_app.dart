import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class ForDevApp extends StatelessWidget {
  const ForDevApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ForDev',
      home: LoginPage(),
    );
  }
}
