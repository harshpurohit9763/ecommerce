import 'package:ecommerce_app/controller/app_common_Controller.dart';
import 'package:ecommerce_app/router/router.dart';
import 'package:ecommerce_app/view/cart/cart_screen.dart';
import 'package:ecommerce_app/view/home/homepage.dart';
import 'package:ecommerce_app/view/home/product_detial_screen.dart';
import 'package:ecommerce_app/view/orders/order_detail_screen.dart';
import 'package:ecommerce_app/view/orders/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialPage = AppRoutes.initialPage;

  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initialPage,
      page: () => Homepage(),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () => CartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.productDetailScreen,
      page: () => ProductDetialScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.orderHistoryScreen,
      page: () => OrderHistoryScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.orderHistoryDetailScreen,
      page: () => OrderDetailScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: '/product/:id', // Dynamic route to capture product ID
      page: () {
        final productId = Get.parameters['id'] ?? "";
        CommonAppController commonAppController =
            Get.put(CommonAppController());

        // Use FutureBuilder to handle async operation
        return FutureBuilder(
          future: commonAppController
              .handleSharedLink("https://fakestoreapi.com/product/$productId"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting for data
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              // Handle error if the Future fails
              return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')));
            } else if (snapshot.hasData) {
              // If the data is available, navigate to ProductDetailScreen
              return ProductDetialScreen();
            } else {
              // If there's no data, navigate to the homepage
              return Homepage();
            }
          },
        );
      },
    ),
  ];
}
