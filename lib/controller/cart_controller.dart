import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/model/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  @override
  onInit() {
    super.onInit();
    retriveOrderHistoryFromSharedPref();
  }

  List<ProductsModel> cartItems = []; // used to store the items in the cart
  List<List<ProductsModel>> orderHistory = []; // used to show list of orders
  List<ProductsModel> tempItems =
      []; // used to show the list of items in the order history detail screen
  ProductsModel selectedProductInfo =
      ProductsModel(); // used to show the detail view of product

  //Add the current product to cart if akready added increase the quantity
  addToCart(ProductsModel product) {
    if (cartItems.any((element) => element.id == product.id) == true) {
      int updateCountIndex = cartItems.indexWhere(
        (element) => element.id == product.id,
      );
      cartItems[updateCountIndex].quantity++;
      log(cartItems[updateCountIndex].quantity.toString());
      update();
    } else {
      cartItems.add(
        ProductsModel(
          category: product.category,
          description: product.description,
          id: product.id,
          image: product.image,
          price: product.price,
          quantity: 1,
          rating: product.rating,
          title: product.title,
        ),
      );
    }
    update();
  }

  //remove the current from cart if quantity is more do -1 from total quantity
  removeoneItemOrFromCart(ProductsModel product) {
    // if (cartItems.any((element) => element.id == product.id) == true) {
    int updateCountIndex = cartItems.indexWhere(
      (element) => element.id == product.id,
    );

    if (cartItems[updateCountIndex].quantity > 1) {
      cartItems[updateCountIndex].quantity--;
    } else {
      cartItems.removeAt(updateCountIndex);
      update();
    }
    update();
    // }
  }

  RxDouble cartTotal = (0.0).obs;
  // caculates the cart total and saves it to
  calculateCartTotal() {
    cartTotal.value = 0;
    if (cartItems.isNotEmpty) {
      for (int i = 0; i < cartItems.length; i++) {
        cartTotal.value +=
            (cartItems[i].quantity * cartItems[i].price!).toDouble();
      }
    }
  }

// it saves all the orders into order history
  saveOrderHistoryToSharedPref() async {
    orderHistory.add(cartItems);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(
      orderHistory
          .map((order) => order.map((item) => item.toJson()).toList())
          .toList(),
    );
    await pref.setString("order_history", jsonString);
    cartItems.clear();
    update();
  }

  RxBool historyLoading = false.obs;

  //retrives the order history for the user
  retriveOrderHistoryFromSharedPref() async {
    historyLoading(true);
    update();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? getString = pref.getString("order_history");
    if (getString == null) {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(getString);
    log("this is json data$jsonList");

    if (jsonList.isNotEmpty) {
      orderHistory = jsonList
          .map((order) => (order as List<dynamic>)
              .map((item) =>
                  ProductsModel.fromJson(item as Map<String, dynamic>))
              .toList())
          .toList();
      historyLoading(false);
      update();
    } else {
      orderHistory = [];
    }
    historyLoading(false);
    update();
  }
}
