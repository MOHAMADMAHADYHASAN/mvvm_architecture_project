abstract class BaseApiServices {


  Future<dynamic> getGetApiServices(String url, {String? token});

  Future<dynamic> postApiServices(String url, dynamic data, {String? token});
  Future<dynamic> patchApiServices(String url, {String? token});
  Future<dynamic> deleteApiServices(String url, {String? token});
}