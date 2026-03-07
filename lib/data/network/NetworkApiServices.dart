import 'dart:convert';
import 'dart:io';
import 'package:mvvm_app/data/app_exception.dart';
import 'BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//কাজ:(NetworkApiServices) এর কাজ শুধু ইন্টারনেটের মাধ্যমে নির্দিষ্ট ঠিকানায় (URL) যাওয়া এবং ডেটা নিয়ে ফিরে আসা।
// সে জানে না ডেটা দিয়ে কী হবে, সে শুধু এনে দেয়।

class NetworkApiServices extends BaseApiServices {
  @override
  // get request............
  Future getGetApiServices(String url) async {
    ///???
    dynamic responseJson;

    try {
      // hit link on internet   by http.get()........... and store in response
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));

      /// for any errror========================
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future postApiServices(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(Duration(seconds: 10));

      /// for any errror========================
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(message: "${response.statusCode}");
      case 401:
      case 403:
        throw UnauthorisedException(message: response.body);
      case 404:
        throw NotFoundException(
          message: "Page not found:${response.statusCode}",
        );

      default:
        throw FetchDataException(
          message:
              "Error occurred while communication with server with status code: ${response.statusCode}",
        );
    }
  }
}
