import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/custom_text_field.dart';
import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../viewModel/auth_View_Model.dart';

class Signupview extends StatefulWidget {
  const Signupview({super.key});

  @override
  State<Signupview> createState() => _SignupviewState();
}

class _SignupviewState extends State<Signupview> {
  final _formKey = GlobalKey<FormState>();

  //  পাসওয়ার্ড লুকানো/দেখানোর জন্য স্মার্ট ভেরিয়েবল (setState দরকার নেই)
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // কিবোর্ডের ফোকাস কন্ট্রোল করার জন্য (কার্সর কোথায় থাকবে)
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obsecurePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // authViewModel cinnection (viewmodel)........
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // MediaQuery Size.....................
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // ২. স্ক্রল ভিউ যাতে ছোট ফোনে ওভারফ্লো না হয়
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: Colors.blueGrey.shade400,
                ),
                SizedBox(height: height * 0.02),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "Sign up to get started",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: height * 0.05),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
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
                        // ভ্যালিডেশন যোগ করা হয়েছে
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.02),

                      //এই বিল্ডারটি _obsecurePassword এর দিকে তাকিয়ে থাকবে
                      ValueListenableBuilder(
                        valueListenable: _obsecurePassword,
                        builder: (context, value, child) {
                          return CustomTextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            label: "Password",
                            hint: "Enter password",
                            prefixIcon: Icons.lock_outline,

                            obscureText: _obsecurePassword.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                // টগল লজিক: সত্য থাকলে মিথ্যা, মিথ্যা থাকলে সত্য হবে
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

                      SizedBox(height: height * 0.04),

                      Consumer<AuthViewModel>(
                        builder: (context, value, child) {
                          return RoundButton(
                            loading: value.signUpLoading,
                            title: "SIGN UP",
                            onPress: () {
                              if (emailController.text.isEmpty) {
                                utils.flashBarErrorMessage(
                                  "Please enter email",
                                  context,
                                );
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  // creating data packet...................
                                  Map data = {
                                    "email": emailController.text
                                        .trim()
                                        .toString(),
                                    "password": passwordController.text
                                        .trim()
                                        .toString(),
                                  };
                                  // ২. ওয়েটার (View) ম্যানেজারকে (ViewModel) অর্ডার দিল
                                  authViewModel.singInApi(data, context);
                                  // eta shuno tokhn print hbe jokkhn  apps developper mode e thakbe relase mode ignore korbe
                                  if (kDebugMode) {
                                    print('Api hit successful');
                                  }
                                }
                              }
                            },
                          );
                        },
                      ),

                      SizedBox(height: height * 0.03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routesname.login);
                            },
                            child: Text(
                              "Log In",
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
