import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes_name.dart';
import 'package:mvvm_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../res/components/custom_text_field.dart';
import '../res/components/round_button.dart';
import '../viewModel/auth_View_Model.dart';
import 'package:flutter/foundation.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();

  //  পাসওয়ার্ড লুকানো/দেখানোর জন্য স্মার্ট ভেরিয়েবল (setState দরকার নেই)
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController emailContriller = TextEditingController();
  TextEditingController passworldController = TextEditingController();

  // কিবোর্ডের ফোকাস কন্ট্রোল করার জন্য (কার্সর কোথায় থাকবে)
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obsecurePassword.dispose();
    emailContriller.dispose();
    passworldController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // authViewModel cinnection (viewmodel)........
    final authViewModel = Provider.of<AuthViewModel>(context,listen: false);
    // MediaQuery Size.....................
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      backgroundColor: Colors.white, // ১. ক্লিন ব্যাকগ্রাউন্ড কালার
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // ২. স্ক্রল ভিউ যাতে ছোট ফোনে সমস্যা না হয়
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_person_rounded,
                  size: 80,
                  color: Colors.blueGrey.shade400,
                ),
                SizedBox(height: height * 0.02),

                const Text(
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "Enter your details to login",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: height * 0.05),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailContriller,
                        //field focus change korar jonno.....
                        focusNode: emailFocusNode,
                        label: "Email Address",
                        hint: "Enter your email",
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,

                        // লজিক: যখন ইউজার কিবোর্ডে এন্টার/নেক্সট চাপবে
                        onFieldSubmitted: (value) {
                          // এই ফাংশনটি ইমেইল থেকে ফোকাস সরিয়ে পাসওয়ার্ডে নিয়ে যাবে
                          utils.fieldFocusChange(
                            context,
                            emailFocusNode,
                            passwordFocusNode,
                          );
                        },
                        //validator: ,
                      ),

                      SizedBox(height: height * 0.02),
                      //এই বিল্ডারটি _obsecurePassword এর দিকে তাকিয়ে থাকবে
                      ValueListenableBuilder(
                        valueListenable: _obsecurePassword,

                        builder: (context, value, child) {
                          return CustomTextField(
                            controller: passworldController,
                            focusNode: passwordFocusNode,
                            label: "Password",
                            hint: "Enter password",
                            prefixIcon: Icons.lock_outline,

                            // পাসওয়ার্ড হাইড/শো লজিক এখান থেকে পাঠাচ্ছি
                            obscureText: _obsecurePassword.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              icon: Icon(
                                _obsecurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else if (value.length < 6) {
                                return "Enter 6 digits";
                              }
                              return null;
                            },
                          );
                        },
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            //
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      Consumer<AuthViewModel>(builder: (context,value,child){
                        return  RoundButton(
                          loading: value.loading,
                          title: "LOGIN",
                          onPress: () {
                            if (emailContriller.text.isEmpty) {
                              utils.flashBarErrorMessage(
                                "Please enter email",
                                context,
                              );
                            } else {
                              if (_formKey.currentState!.validate()) {
                                //creating data packet...................
                                Map data = {
                                  "email": emailContriller.text.toString(),
                                  "password": passworldController.text.toString(),
                                };

                                // ২. ওয়েটার (View) ম্যানেজারকে (ViewModel) অর্ডার দিল
                                authViewModel.logInApi(data, context);
                                // eta shuno tokhn print hbe jokkhn  apps developper mode e thakbe relase mode ignore korbe
                                if (kDebugMode) {
                                  print('Api hit successful');
                                }
                              }
                            }
                          },
                        );
                      }),

                      SizedBox(height: height * 0.02),
                      RoundButton(
                        title: " Home ",
                        onPress: () {
                          Navigator.pushNamed(context, Routesname.home);
                        },
                      ),

                      SizedBox(height: height * 0.03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routesname.singup);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
