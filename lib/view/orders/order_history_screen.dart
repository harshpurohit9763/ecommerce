import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/constants/image_constants.dart';
import 'package:ecommerce_app/constants/my_elevated_button.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Order History".tr,
                    style: GoogleFontExtension.bodyTextNormal(size: 22),
                  ),
                ],
              ),
            ),
            GetBuilder<CartController>(
                init: CartController(),
                builder: (crtController) {
                  return crtController.historyLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : crtController.orderHistory.isEmpty ||
                              crtController.orderHistory == []
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      ImageConstants.noOrderHistory,
                                    ),
                                  ),
                                  CustomElevatedButton(
                                    text: "Buy Now".tr,
                                    onPressed: Get.back,
                                  )
                                ],
                              ),
                            )
                          : Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                              children: List.generate(
                                crtController.orderHistory.length,
                                (index) {
                                  List<ProductsModel> singleHistory =
                                      crtController.orderHistory[index];
                                  double orderTotalSingleItem = 0;
                                  for (int i = 0;
                                      i < singleHistory.length;
                                      i++) {
                                    orderTotalSingleItem +=
                                        singleHistory[i].quantity *
                                            singleHistory[i].price!;
                                  }
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Card(
                                      elevation: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${"Order No".tr} :\n ${index + 1}",
                                                style: GoogleFontExtension
                                                    .bodyTextNormal(size: 18),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                  "${"Ordered".tr} : \n${singleHistory.length} ${"items".tr}"
                                                      .tr,
                                                  style: GoogleFontExtension
                                                      .bodyTextNormal(
                                                          size: 18)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                  "${"Order Total".tr} : \n\$${orderTotalSingleItem.toStringAsFixed(2)}"
                                                      .tr,
                                                  style: GoogleFontExtension
                                                      .bodyTextNormal(
                                                          size: 18)),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                          CustomElevatedButton(
                                            onPressed: () {
                                              crtController.tempItems.clear();
                                              for (var i = 0;
                                                  i < singleHistory.length;
                                                  i++) {
                                                crtController.tempItems
                                                    .add(singleHistory[i]);
                                              }
                                              Get.toNamed(AppRoutes
                                                  .orderHistoryDetailScreen);
                                            },
                                            text: "View Info".tr,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )));
                })
          ],
        ),
      ),
    );
  }
}
