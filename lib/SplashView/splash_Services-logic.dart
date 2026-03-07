import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';
import '../viewModel/user_View_Model.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();

    try {
      // ১. ইউজারের ডেটা রিড করার কাজ শুরু করো (await ব্যবহার করে)
      final value = await userViewModel.getUser();

      // ২. কমপক্ষে ২ সেকেন্ড অপেক্ষা করো যাতে ইউজার স্প্ল্যাশ স্ক্রিনটি দেখতে পায়
      await Future.delayed(const Duration(seconds: 2));

      // ৩. নেভিগেশন করার আগে চেক করো যে উইজেটটি এখনো স্ক্রিনে আছে কি না
      if (!context.mounted) return;

      // ৪. টোকেন চেক করার লজিক
      // টোকেন যদি নাল হয়, অথবা স্ট্রিং হিসেবে 'null' থাকে, অথবা খালি থাকে
      if (value.token == null ||
          value.token.toString() == 'null' ||
          value.token == "") {
        Navigator.pushReplacementNamed(context, Routesname.login);
      } else {
        Navigator.pushReplacementNamed(context, Routesname.home);
      }
    } catch (error) {
      // ৫. যদি কোনো বড় ধরনের এরর হয় (যেমন ডাটাবেস এরর)
      debugPrint("Splash error: $error");

      // এরর হলে সেফটি হিসেবে ইউজারকে লগইন স্ক্রিনেই পাঠিয়ে দেওয়া ভালো
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, Routesname.login);
      }
    }
  }
}
