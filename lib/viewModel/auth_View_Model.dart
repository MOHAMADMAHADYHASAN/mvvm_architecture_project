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
    // ১. ম্যানেজার বলল: "কাজ শুরু হচ্ছে, সবাইকে জানাও" (চাকা ঘোরাও)
    setLoading(true);
    // ২. ম্যানেজার রাঁধুনিকে (Repository) বলল: "API তে হিট করো"
    // .then(value ) ta holo server theke j data (response) ta return kore e´seta ekhane ese thake
    // response = value

    await my_AuthRepo
        .loginApi(data)
        // ৩. যদি রান্না সফল হয় (Success)
        .then((value) {
          // চাকা বন্ধ
          setLoading(false);
          final userPreference = Provider.of<UserViewModel>(
            context,
            listen: false,
          );

          /// data save korar jonno..................................
          ///  data packet ti  UserModel ক্লাসের fromJson মেশিনে ঢুকিয়ে দিচ্ছে

          userPreference.saveUser(UserModel.fromJson(value));

          utils.flashBarErrorMessage("login Successfully", context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            Routesname.home,
            (route) => false,
          );
          // print only whene the app is on developer mode
          if (kDebugMode) {
            print(value.toString());
          }
        })
        // ৪. যদি রান্না পুড়ে যায় (Error)
        .onError((error, stackTrace) {
          // চাকা বন্ধ
          setLoading(false);
          utils.flashBarErrorMessage(error.toString(), context);

          // print only whene the app is on developer mode
          //  এটা শুধু আপনার জন্য (ডেভেলপার)
          if (kDebugMode) {
            print("Error Log: " + error.toString());
          }
        });
  }

  Future<void> singInApi(dynamic data, BuildContext context) async {
    // ১. ম্যানেজার বলল: "কাজ শুরু হচ্ছে, সবাইকে জানাও" (চাকা ঘোরাও)
    setSignUpLoading(true);
    // ২. ম্যানেজার রাঁধুনিকে (Repository) বলল: "API তে হিট করো"
    // .then(value ) ta holo server theke j data (response) ta return kore e´seta ekhane ese thake
    // response = value

    my_AuthRepo
        .signupApi(data)
        // ৩. যদি রান্না সফল হয় (Success)
        .then((value) {
          // চাকা বন্ধ
          setSignUpLoading(false);
          utils.flashBarErrorMessage("SingUp Successfully", context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            Routesname.home,
            (route) => false,
          );
          // print only whene the app is on developer mode
          if (kDebugMode) {
            print(value.toString());
          }
        })
        // ৪. যদি রান্না পুড়ে যায় (Error)
        .onError((error, stackTrace) {
          // চাকা বন্ধ
          setSignUpLoading(false);
          utils.flashBarErrorMessage(error.toString(), context);

          // print only whene the app is on developer mode
          //  এটা শুধু আপনার জন্য (ডেভেলপার)
          if (kDebugMode) {
            print("Error Log: " + error.toString());
          }
        });
  }
}
