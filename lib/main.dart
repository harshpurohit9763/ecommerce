import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:ecommerce_app/controller/app_common_Controller.dart';
import 'package:ecommerce_app/router/routes_constant.dart';
import 'package:ecommerce_app/services/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => GetBuilder<CommonAppController>(
          init: CommonAppController(),
          builder: (commonAppController) {
            return GetMaterialApp(
              navigatorKey: navigatorKey,
              translations: AppTranslations(), // translation file
              locale: Locale(
                  commonAppController.userlocaleDefault), // Default language
              fallbackLocale: Locale('en'), // Fallback language
              builder: EasyLoading.init(), // initilise easyloading
              theme: commonAppController.isDarkTheme.value
                  ? ThemeData.dark()
                  : ThemeData.light(),
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.initialPage, // initial page
              getPages: AppPages.pages, // app pages
            );
          }),
    );
  }
}
