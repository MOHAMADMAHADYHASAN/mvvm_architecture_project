import 'package:flutter/material.dart';
import 'package:mvvm_app/SplashView/splash_Services-logic.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    lowerBound: 0.8,
    upperBound: 1.2,
  )..repeat(reverse: true);
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.50,
                child: Center(
                  child: Image(image: AssetImage("images/secure.png")),
                ),
              ),
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Authentication",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.blueGrey),
                ))
          ],
        ),
      ),
    );
  }
}
