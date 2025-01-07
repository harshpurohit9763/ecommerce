import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/constants/image_constants.dart';
import 'package:ecommerce_app/constants/my_elevated_button.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cartController) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: cartController.cartItems.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image:
                                    AssetImage(ImageConstants.emptyCartImage),
                              ),
                              Text(
                                "Notihing to show\nAdd Items to Cart".tr,
                                style: GoogleFontExtension.bodyTextNormal(
                                    size: 22),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomElevatedButton(
                                  onPressed: Get.back, text: "Shop Now".tr)
                            ],
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: Get.back,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 32.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "${"Your Cart Total".tr} \n\$ ${cartController.cartTotal.toStringAsFixed(2)}",
                                  style: GoogleFontExtension.bodyTextNormal(
                                      size: 22),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: ColourConstant.dividerColor,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Cart Items".tr,
                            style: GoogleFontExtension.bodyTextNormal(size: 22),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  cartController.cartItems.length,
                                  (index) {
                                    var product =
                                        cartController.cartItems[index];

                                    int IncartIndex =
                                        cartController.cartItems.indexWhere(
                                      (element) => element.id == product.id,
                                    );
                                    return Card(
                                      elevation: 10,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 0.45.sw,
                                                  child: Text(
                                                      cartController
                                                              .cartItems[index]
                                                              .title ??
                                                          "",
                                                      maxLines: 2),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color: ColourConstant
                                                        .dividerColor,
                                                  )),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        color: ColourConstant
                                                            .primamryColour,
                                                        child: IconButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          onPressed: () {
                                                            cartController
                                                                .removeoneItemOrFromCart(
                                                                    product);
                                                          },
                                                          icon: Icon(
                                                            Icons.remove,
                                                            size: 20.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Text(
                                                          cartController
                                                              .cartItems[
                                                                  IncartIndex]
                                                              .quantity
                                                              .toString(),
                                                          style:
                                                              GoogleFontExtension
                                                                  .bodyTextNormal(
                                                                      size: 18
                                                                          .sp),
                                                        ),
                                                      ),
                                                      Container(
                                                        color: ColourConstant
                                                            .primamryColour,
                                                        child: IconButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          onPressed: () {
                                                            cartController
                                                                .addToCart(
                                                                    product);
                                                          },
                                                          icon: Icon(
                                                            Icons.add,
                                                            size: 22.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "\$${product.quantity * product.price!}",
                                                style: GoogleFontExtension
                                                    .bodyTextNormal(
                                                  size: 14,
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
                          Container(
                            height: 0.07.sh,
                          )
                        ],
                      ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: cartController.cartItems.isEmpty
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: GestureDetector(
                      onTap: () {
                        cartController.saveOrderHistoryToSharedPref();
                        Get.back();
                        EasyLoading.showSuccess(
                            "Successfully Purchased Order".tr);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColourConstant.primamryColour,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        height: 0.055.sh,
                        child: Center(
                          child: Text(
                            "buy".tr,
                            style: GoogleFontExtension.buttonTextLight(
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
