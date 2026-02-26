import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';
import 'package:mvvm_app/viewModel/auth_View_Model.dart';
import 'package:mvvm_app/viewModel/home_View_model.dart';
import 'package:mvvm_app/viewModel/user_View_Model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "flutter demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity(),
        ),
        initialRoute: Routesname.splash,
        onGenerateRoute: Routes.generationRoute,
      ),
    );
  }
} 
