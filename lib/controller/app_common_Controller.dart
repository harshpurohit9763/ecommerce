import 'dart:convert';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/router/router.dart';
import 'package:ecommerce_app/services/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonAppController extends GetxController {
  @override
  onInit() {
    super.onInit();
    loadThemePreference();
    getLocale();
    deepLinks();
  }

// listen to link and do the following operation
  deepLinks() {
    final applinks = AppLinks();
    final sub = applinks.uriLinkStream.listen(
      (uri) {
        log("gatttaaaaaa    " + uri.toString());
        final id = uri.pathSegments.lastOrNull;
        if (id != null) {
          handleSharedLink(uri.toString());
        }
      },
    );
  }

  CartController cartController = Get.put(CartController());
//used to open the product page when clicked on the link
  handleSharedLink(String link) async {
    // Parse the URL
    final Uri uri = Uri.parse(link);
    final productId = uri.pathSegments.last;

    // Navigate to the product detail screen based on the ID
    var response =
        await ApiBase.getRequest(extendedURL: '/products/$productId');
    if (response.statusCode == 200 || response.statusCode == 201) {
      cartController.selectedProductInfo =
          ProductsModel.fromJson(jsonDecode(response.body));
      Get.toNamed(AppRoutes.productDetailScreen);
    } else {
      Get.toNamed(AppRoutes.homePage);
    }
  }

  RxBool isDarkTheme = false.obs;

  // Function to toggle the theme
  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;

    // Apply the selected theme
    Get.changeTheme(
      isDarkTheme.value ? ThemeData.dark() : ThemeData.light(),
    );
    saveThemePreference(isDarkTheme.value);
    update();
    loadThemePreference();
    update();
  }

  // load theme from shared preference
  Future<void> loadThemePreference() async {
    final themePref = await SharedPreferences.getInstance();
    isDarkTheme.value = themePref.getBool('isDarkTheme') ?? false;

    // Apply the saved theme
    Get.changeTheme(
      isDarkTheme.value ? ThemeData.dark() : ThemeData.light(),
    );
    update();
  }

  // Save theme preference in sharedpreference
  Future<void> saveThemePreference(bool isDark) async {
    final themePref = await SharedPreferences.getInstance();
    await themePref.setBool('isDarkTheme', isDark);
  }

  // save selected language to sharedpref
  saveLanguageLocal(String localefromUser) async {
    final locale = await SharedPreferences.getInstance();
    await locale.setString("locale", localefromUser);
    log("saved $localefromUser");
  }

  String userlocaleDefault = "en";
  // get selected language from sharedpref
  getLocale() async {
    final locale = await SharedPreferences.getInstance();

    var data = await locale.getString("locale");
    if (data != null) {
      userlocaleDefault = data;
      update();
      Get.updateLocale(Locale(userlocaleDefault));
      log(userlocaleDefault);
    } else {
      userlocaleDefault = "en";
      Get.updateLocale(Locale(userlocaleDefault));
      update();
      log(userlocaleDefault);
    }
  }
}
