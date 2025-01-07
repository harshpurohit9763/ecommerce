import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// this is the widget that is used to show the products in card in the home screen
class ProductCard extends StatelessWidget {
  ProductsModel product;

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cartController) {
          var isPresesentInCart = cartController.cartItems.any(
            (element) => element.id == product.id,
          );

          int incartIndex = cartController.cartItems.indexWhere(
            (element) => element.id == product.id,
          );
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartController.selectedProductInfo = product;
                        cartController.update();
                        Get.toNamed(AppRoutes.productDetailScreen);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product.image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.title ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              SizedBox(width: 5),
                              Text(
                                '${product.rating?.rate} (${product.rating?.count} ratings)',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                    isPresesentInCart
                        ? Container(
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
                                      cartController
                                          .removeoneItemOrFromCart(product);
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                Text(
                                  cartController.cartItems[incartIndex].quantity
                                      .toString(),
                                  style: GoogleFontExtension.bodyTextNormal(
                                      size: 22.sp),
                                ),
                                Container(
                                  color: ColourConstant.primamryColour,
                                  child: IconButton(
                                    onPressed: () {
                                      cartController.addToCart(product);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            // width: 0.2.sw,
                            color: ColourConstant.ternaryColour,
                            height: 35.h,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  cartController.addToCart(product);
                                },
                                child: Text(
                                  "Buy".tr,
                                  style: GoogleFontExtension.buttonTextLight(
                                      size: 16),
                                ),
                              ),
                            ),
                          )
                    // CustomElevatedButton(
                    //     padding: EdgeInsets.symmetric(horizontal: 54),
                    //     onPressed: () {
                    //       cartController.addToCart(product);
                    //     },
                    //     text: "Buy")
                  ],
                ),
              ),
            ),
          );
        });
  }
}
