import 'package:flutter/cupertino.dart';
import 'package:mvvm_app/data/response/api_response.dart';
import 'package:mvvm_app/model/ProductModel.dart';

import '../repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final my_repo = HomeRepository();

  // like getter method
  // সে productList এর স্ট্যাটাস Status.LOADING করে দেয়।
  //step 2
  ApiResponse<ProductModel> productList = ApiResponse.loading();

  // like setter method
  setProductList(ApiResponse<ProductModel> ldng_cmplt_errr) {
    productList = ldng_cmplt_errr;
    notifyListeners();
  }

  Future<void> fetchProductListApi() async {
    // লোডিং শুরু
    setProductList(ApiResponse.loading());
    //HomeRepository কে কল করে বলে ডেটা আনতে।
    try {
      // ২. await ব্যবহার করে সরাসরি ডেটা নিয়ে আসা (কোনো then দরকার নেই)
      final value = await my_repo.featch_productModel();

      // ৩. ডেটা সফলভাবে আসলে Completed স্টেট সেট করা
      setProductList(ApiResponse.completed(value));
    } catch (e) {
      // ৪. যেকোনো এরর (নেটওয়ার্ক বা ডেটাবেস) সরাসরি এখানে ধরা পড়বে
      debugPrint("API Error: $e"); // ডিবাগ করার সুবিধার জন্য
      setProductList(ApiResponse.error(e.toString()));
    }
  }
}
