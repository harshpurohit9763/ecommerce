// import 'package:ecommerce_app/controller/cart_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class ProductDetialScreen extends StatelessWidget {
//   const ProductDetialScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(
//         init: CartController(),
//         builder: (ctrl) {
//           return Scaffold();
//         });
//   }
// }

import 'dart:developer';

import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/constants/my_elevated_button.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetialScreen extends StatelessWidget {
  const ProductDetialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (ctrl) {
        var isPresesentInCart = ctrl.cartItems.any(
          (element) => element.id == ctrl.selectedProductInfo.id,
        );
        int incartIndex = ctrl.cartItems.indexWhere(
          (element) => element.id == ctrl.selectedProductInfo.id,
        );
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(ctrl.selectedProductInfo.title ?? 'Product Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          String productUrl =
                              'https://fakestoreapi.com/products/${ctrl.selectedProductInfo.id}'; // Use actual URL format
                          log(productUrl);
                          Share.share('Check out this product: $productUrl');
                        },
                        icon: Icon(
                          Icons.share,
                          size: 27.sp,
                        ),
                      )
                    ],
                  ),
                  // Product Image
                  Center(
                    child: Image.network(
                      ctrl.selectedProductInfo.image ?? '',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Title
                  Text(
                    ctrl.selectedProductInfo.title ?? '',
                    style: GoogleFontExtension.bodyTextNormal(),
                  ),
                  const SizedBox(height: 8),
                  // Product Description
                  Text(
                    ctrl.selectedProductInfo.description ??
                        'No description available',
                    style: GoogleFontExtension.bodyTextNormal(),
                  ),
                  const SizedBox(height: 16),
                  // Product Price
                  Text(
                    '\$${ctrl.selectedProductInfo.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: GoogleFontExtension.bodyTextNormal(),
                  ),
                  const SizedBox(height: 16),
                  // Product Rating
                  if (ctrl.selectedProductInfo.rating != null)
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${ctrl.selectedProductInfo.rating?.rate ?? 0.0} (${ctrl.selectedProductInfo.rating?.count ?? 0} reviews)',
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          floatingActionButton: isPresesentInCart
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: ColourConstant.dividerColor,
                      )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: ColourConstant.primamryColour,
                            child: IconButton(
                              onPressed: () {
                                ctrl.removeoneItemOrFromCart(
                                    ctrl.selectedProductInfo);
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              ctrl.cartItems[incartIndex].quantity.toString(),
                              style: GoogleFontExtension.bodyTextNormal(
                                  size: 22.sp),
                            ),
                          ),
                          Container(
                            color: ColourConstant.primamryColour,
                            child: IconButton(
                              onPressed: () {
                                ctrl.addToCart(ctrl.selectedProductInfo);
                              },
                              icon: Icon(
                                Icons.add,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        // Add to cart action
                        ctrl.addToCart(ctrl.selectedProductInfo);
                      },
                      text: 'Add to Cart'.tr,
                    ),
                  ],
                )
              : CustomElevatedButton(
                  onPressed: () {
                    // Add to cart action
                    ctrl.addToCart(ctrl.selectedProductInfo);
                  },
                  text: 'Add to Cart'.tr,
                ),
        );
      },
    );
  }
}
