import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../ui/components/app_theme.dart';
import '../../utils/i18n/i18n.dart';
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
      initialRoute: AppRoutes.root,
      getPages: [
        GetPage(
          name: AppRoutes.root,
          page: SplashPageFactory.makeSplashPage,
        ),
        GetPage(
          name: AppRoutes.login,
          page: LoginPageFactory.makeLoginPage,
          transition: Transition.fade,
        ),
        GetPage(
          name: AppRoutes.surveys,
          page: () => Scaffold(
            body: Text(R.strings.surveys),
          ),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
