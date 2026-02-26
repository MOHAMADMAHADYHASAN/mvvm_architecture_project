import 'package:flutter/cupertino.dart';
import 'package:mvvm_app/data/response/api_response.dart';
import 'package:mvvm_app/model/ProductModel.dart';

import '../repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final my_repo = HomeRepository();
  // like getter method
 // সে productList এর স্ট্যাটাস Status.LOADING করে দেয়।
  //step 2
  ApiResponse <ProductModel> productList = ApiResponse.loading();
// like setter method
  setProductList(ApiResponse<ProductModel> ldng_cmplt_errr) {
    productList = ldng_cmplt_errr;
    notifyListeners();
  }

  Future<void> fetchProductListApi() async {
    // লোডিং শুরু
    setProductList(ApiResponse.loading());
    //HomeRepository কে কল করে বলে ডেটা আনতে।
    my_repo
        .featch_productModel()
    //return response = ProductModel.fromJson(response);= value
        .then((value) {
          setProductList(ApiResponse.completed(value));
        })
        .onError((error, stackTrace) {
          setProductList(ApiResponse.error(error.toString()));
        });
  }
}
