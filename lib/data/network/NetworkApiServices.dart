import 'dart:convert';
import 'dart:io';
import 'package:mvvm_app/data/app_exception.dart';
import 'BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  // get request............
  Future getGetApiServices(String url, {String? token}) async {
    ///???
    dynamic responseJson;

    try {
      // hit link on internet   by http.get()........... and store in response
      final response = await http
          .get(
            Uri.parse(url),
            headers: {if (token != null) "Authorization": "Bearer $token"},
          )
          .timeout(Duration(seconds: 10));

      /// for any errror========================
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future postApiServices(String url, dynamic data, {String? token}) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));

      /// for any errror========================
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> patchApiServices(String url, {String? token}) async {
    dynamic responseJson;
    try {
      Response response = await patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApiServices(String url, {String? token}) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(message: jsonDecode(response.body)['message'] ?? "${response.statusCode}");
      case 401:
      case 403:
        throw UnauthorisedException(message: jsonDecode(response.body)['message'] ?? response.body);
      case 404:
        throw NotFoundException(message:  jsonDecode(response.body)["message"]?? response.body
        );

      default:
        throw FetchDataException(
          message:
              "Error occurred while communication with server with status code: ${response.statusCode}",
        );
    }
  }
}
