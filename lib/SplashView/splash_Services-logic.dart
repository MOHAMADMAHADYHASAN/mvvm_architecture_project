import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_app/model/user_Model.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';

import '../viewModel/user_View_Model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData()
        .then((value)async {
          if (value.token == "null" || value.token == "") {
            await Future.delayed(Duration(seconds: 2));
            Navigator.pushNamed(context, Routesname.login);
          } else {
            await Future.delayed(Duration(seconds: 2));
            Navigator.pushNamed(context, Routesname.home);
          }
        })
        .onError((error, stackTrace) {
          if (kDebugMode) {
            print("Error :" + error.toString());
          }
        });
  }
}
