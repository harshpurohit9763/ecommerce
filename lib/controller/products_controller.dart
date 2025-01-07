import 'dart:developer';

import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/services/api_constant.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getProducts();
  }

  List<ProductsModel> productsData = [];
  RxBool isproductsLoading = false.obs;

  //Used to fetch the products from the api
  getProducts() async {
    isproductsLoading(true);
    productsData = [];
    var response = await ApiBase.getRequest(extendedURL: '/products');
    if (response.statusCode == 200 || response.statusCode == 201) {
      productsData = productsModelFromJson(response.body);
      filteredProducts.assignAll(productsData);
    } else {
      log("something went wrong ${response.body}");
    }
    isproductsLoading(false);
  }

  ///stores the filterd list of products
  var filteredProducts = <ProductsModel>[].obs; // Displayed list of products

  //sort the products as per conditions
  void sortProducts(String criteria) {
    if (criteria == 'price_asc') {
      filteredProducts.sort((a, b) => a.price!.compareTo(b.price!));
    } else if (criteria == 'price_desc') {
      filteredProducts.sort((a, b) => b.price!.compareTo(a.price!));
    } else if (criteria == 'name') {
      filteredProducts.sort((a, b) => a.title!.compareTo(b.title!));
    }
    update();
  }

  //filter the products as per conditions
  void filterProducts(Category category) {
    if (category == Category.All) {
      filteredProducts.assignAll(productsData);
    } else {
      filteredProducts.assignAll(
          productsData.where((product) => product.category == category));
    }
    update();
  }
}
