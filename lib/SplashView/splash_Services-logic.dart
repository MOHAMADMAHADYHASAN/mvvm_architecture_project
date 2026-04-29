import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';
import '../viewModel/user_View_Model.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();
    try {
       final value = await userViewModel.getUser();

       await Future.delayed(const Duration(seconds: 2));

       if (!context.mounted) return;


      if (value.token == null ||
          value.token.toString() == 'null' ||
          value.token == "") {
        Navigator.pushReplacementNamed(context, Routesname.login);
      } else {
        Navigator.pushReplacementNamed(context, Routesname.main);
      }
    } catch (error) {
       debugPrint("Splash error: $error");

       if (context.mounted) {
        Navigator.pushReplacementNamed(context, Routesname.login);
      }
    }
  }
}
