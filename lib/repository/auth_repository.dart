import 'package:mvvm_app/data/network/BaseApiServices.dart';
import 'package:mvvm_app/data/network/NetworkApiServices.dart';
import 'package:mvvm_app/res/app_url.dart';

class AuthRepository {
  // Upcasting or Polymorphism
  //mobilephone a1=iphone12();
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi( dynamic data) async {
    try {
      // ১. শেফ জানে ঠিক কোন লিঙ্কে (AppUrl.logInUrl) হিট করতে হবে
      dynamic response = await _apiServices.getPostApiServices(
        AppUrl.logInUrl,
        data,
      );
// response is going to auth view model (.then((value))
      return response;
    } catch (e) {
      throw e;
    }
  }

  ////////////
  Future<dynamic>signupApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiServices(
        AppUrl.signupUrl,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
