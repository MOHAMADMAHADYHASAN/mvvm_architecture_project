import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';
import 'package:mvvm_app/view/login_view.dart';

import '../../SplashView/SplashView.dart';
import '../../view/main_screen.dart';
import '../../view/signUpView.dart';

class Routes {
  //Route id type
  //generationRoute() this is function
  ///(RouteSettings settings) settings is an input
  static Route<dynamic> generationRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashView(),
        );


      case Routesname.main:
        return MaterialPageRoute(
          builder: (BuildContext context) => MainScreen(),
        );

      case Routesname.singup:
        return MaterialPageRoute(
          builder: (BuildContext context) => Signupview(),
        );
      case Routesname.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => LogInView(),
        );


      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(body: Center(child: Text("No route defined")));
          },
        );
    }
  }
}
