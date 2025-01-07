import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/controller/app_common_Controller.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/controller/products_controller.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/router/router.dart';
// import 'package:ecommerce_app/router/routes_constant.dart';
import 'package:ecommerce_app/view/widgets/app_bar_constant.dart';
import 'package:ecommerce_app/view/widgets/product_card.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  ProductsController productsController = Get.put(ProductsController());
  CartController cartController = Get.put(CartController());
  CommonAppController themeController = Get.find<CommonAppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
        text: "Products".tr,
        tralingIcon: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Change Language",
                      titleStyle: GoogleFontExtension.bodyTextNormal(size: 18),
                      content: Container(
                        height: 0.25.sh,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeController.saveLanguageLocal("en");
                                Get.updateLocale(Locale('en'));
                                Get.back();
                              },
                              child: Text(
                                "English",
                                style: GoogleFontExtension.bodyTextNormal(
                                    size: 18),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeController.saveLanguageLocal("hi");
                                Get.updateLocale(Locale('hi'));
                                Get.back();
                              },
                              child: Text(
                                "हिंदी",
                                style: GoogleFontExtension.bodyTextNormal(
                                    size: 18),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeController.saveLanguageLocal("mr");
                                Get.updateLocale(Locale('mr'));
                                Get.back();
                              },
                              child: Text(
                                "मराठी",
                                style: GoogleFontExtension.bodyTextNormal(
                                    size: 18),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ));
                  // Get.updateLocale(Locale('fr'));
                  // Get.updateLocale(Locale('hi'));
                },
                icon: Icon(
                  Icons.translate,
                  color: Colors.white,
                  size: 25.sp,
                )),
            SizedBox(
              width: 15.w,
            ),
            IconButton(
                onPressed: () {
                  cartController.retriveOrderHistoryFromSharedPref();
                  cartController.update();
                  Get.toNamed(AppRoutes.orderHistoryScreen);
                },
                icon: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 25.sp,
                )),
            SizedBox(
              width: 15.w,
            ),
            GetBuilder<CommonAppController>(
                init: CommonAppController(),
                builder: (themeController) {
                  return GestureDetector(
                    onTap: () {
                      themeController.toggleTheme();
                    },
                    child: themeController.isDarkTheme.value
                        ? Icon(
                            Icons.sunny,
                            color: Colors.white,
                            size: 25.sp,
                          )
                        : Icon(
                            Icons.dark_mode,
                            color: Colors.grey,
                            size: 25.sp,
                          ),
                  );
                }),
          ],
        ),
      ),
      body: Obx(
        () => productsController.isproductsLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<String>(
                          value: null, // Current selected value
                          hint: Text('Sort By'.tr),
                          items: [
                            DropdownMenuItem(
                                value: 'price_asc',
                                child: Text('Price: Low to High'.tr)),
                            DropdownMenuItem(
                                value: 'price_desc',
                                child: Text('Price: High to Low'.tr)),
                            DropdownMenuItem(
                                value: 'name', child: Text('Name'.tr)),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              productsController.sortProducts(value);
                            }
                          },
                        ),
                        DropdownButton<dynamic>(
                          value: null, // Current selected value
                          hint: Text('Filter By Category'.tr),
                          items: [
                            DropdownMenuItem(
                                value: Category.All, child: Text('All'.tr)),
                            DropdownMenuItem(
                                value: Category.ELECTRONICS,
                                child: Text('Electronics'.tr)),
                            DropdownMenuItem(
                                value: Category.JEWELERY,
                                child: Text('Jewelery'.tr)),

                            DropdownMenuItem(
                                value: Category.MEN_S_CLOTHING,
                                child: Text("Men's Clothing".tr)),
                            DropdownMenuItem(
                                value: Category.WOMEN_S_CLOTHING,
                                child: Text("women's Clothing".tr)),
                            // Add more categories as needed
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              productsController.filterProducts(value);
                            }
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 10.0, // Horizontal spacing between items
                      runSpacing: 10.0, // Vertical spacing between rows
                      children: List.generate(
                        productsController.filteredProducts.length,
                        (index) => SizedBox(
                          width: MediaQuery.of(context).size.width / 2 -
                              15, // Half of the screen width minus padding
                          child: ProductCard(
                            product: productsController.filteredProducts[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
            return GestureDetector(
              onTap: () {
                cartController.calculateCartTotal();
                Get.toNamed(AppRoutes.cartScreen);
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: ColourConstant.dividerColor,
                    child: Icon(
                      Icons.trolley,
                      size: 35.sp,
                    ),
                  ),
                  Positioned(
                    right: -1,
                    top: -2,
                    child: CircleAvatar(
                      backgroundColor: ColourConstant.secondaryColour,
                      child: Text("${cartController.cartItems.length}"),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
