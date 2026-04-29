import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/utils.dart';
import 'package:mvvm_app/viewModel/user_View_Model.dart';
import 'package:provider/provider.dart';

import '../model/user_Model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final my_AuthRepo = AuthRepository();
  bool _loading = false;

  bool get loading => _loading;

  // setLoading(true);
  // setLoading(false);
  setLoading(bool true_false) {
    _loading = true_false;
    notifyListeners();
  }

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool true_false) {
    _signUpLoading = true_false;
    notifyListeners();
  }

  Future<void> logInApi(dynamic data, BuildContext context) async {
     setLoading(true);


    await my_AuthRepo
        .loginApi(data)
         .then((value) {
           setLoading(false);
          final userPreference = Provider.of<UserViewModel>(
            context,
            listen: false,
          );


          userPreference.saveUser(UserModel.fromJson(value));

          utils.flashBarErrorMessage("login Successfully", context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            Routesname.main,
            (route) => false,
          );
          // print only whene the app is on developer mode
          if (kDebugMode) {
            print(value.toString());
          }
        })

        .onError((error, stackTrace) {
          //
          setLoading(false);
          utils.flashBarErrorMessage(error.toString(), context);

          // print only whene the app is on developer mode
          if (kDebugMode) {
            print("Error Log: " + error.toString());
          }
        });
  }

  Future<void> singInApi(dynamic data, BuildContext context) async {


    setSignUpLoading(true);


    my_AuthRepo
        .signupApi(data)

        .then((value) {

          setSignUpLoading(false);
          utils.flashBarErrorMessage("SingUp Successfully", context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            Routesname.main,
            (route) => false,
          );
          // print only whene the app is on developer mode
          if (kDebugMode) {
            print(value.toString());
          }
        })

        .onError((error, stackTrace) {

          setSignUpLoading(false);
          utils.flashBarErrorMessage(error.toString(), context);

          // print only whene the app is on developer mode

          if (kDebugMode) {
            print("Error Log: " + error.toString());
          }
        });
  }
}
