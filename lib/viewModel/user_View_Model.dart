import 'package:flutter/material.dart';

import '../model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  //  data save kora....................
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", user.token ?? "");

    notifyListeners();
    return true;
  }

  // user ber kora splash screen e eti use hoy ...............
  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final String? token = sp.getString("token");
    if (token == null || token == "" || token == "null"){
      return UserModel(token:null);
    }
    return UserModel(token: token.toString());
  }

  //logOut er somoy eti use hoy.......................
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    return true;
  }
}
