import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../ui/components/app_theme.dart';
import '../../utils/i18n/resources.dart';
import '../factories/factories.dart';
import './app_routes.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: R.strings.appName,
      theme: AppTheme.makeMaterialTheme(),
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(name: AppRoutes.login, page: LoginPageFactory.makeLoginPage),
      ],
    );
  }
}
