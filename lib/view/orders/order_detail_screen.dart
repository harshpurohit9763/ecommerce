import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/view/widgets/app_bar_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBarConstant(
        text: "Order Details".tr,
        onPressed: Get.back,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              cartController.tempItems.length,
              (index) {
                var product = cartController.tempItems[index];

                // int IncartIndex = cartController.tempItems.indexWhere(
                //   (element) => element.id == product.id,
                // );
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(
                          product.image!,
                        ),
                        fit: BoxFit.cover,
                        width: 75.w,
                        height: 75.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0.5.sw,
                              child: Text(
                                  cartController.tempItems[index].title ?? "",
                                  maxLines: 2),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                "${cartController.tempItems[index].quantity} ${"at price".tr} \n\$${cartController.tempItems[index].price!} ${"each".tr}"
                                    .toString(),
                                style: GoogleFontExtension.bodyTextNormal(
                                    size: 18.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$${product.quantity * product.price!}",
                            style: GoogleFontExtension.bodyTextNormal(
                              size: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
