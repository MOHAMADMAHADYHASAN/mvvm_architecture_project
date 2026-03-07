import 'package:mvvm_app/data/network/BaseApiServices.dart';
import 'package:mvvm_app/data/network/NetworkApiServices.dart';
import 'package:mvvm_app/model/ProductModel.dart';

import '../res/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<ProductModel> featch_productModel() async {
    try {
      dynamic response = await _apiServices.getGetApiServices(
        AppUrl.productUrl,
      );

      return ProductModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
