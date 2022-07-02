import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../ui/helpers/i18n/resources.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/components/app_theme.dart';

class IOSApp extends StatelessWidget {
  const IOSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: R.strings.appName,
      theme: AppTheme.makeCupertinoTheme(),
      home: const LoginPage(null),
    );
  }
}
