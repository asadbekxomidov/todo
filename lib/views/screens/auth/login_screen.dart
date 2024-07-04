// ignore_for_file: unnecessary_string_escapes, use_build_context_synchronously, deprecated_member_use

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:todo/services/auth_http_services.dart';
import 'package:todo/utils/app_routes.dart';
// import 'package:todo/views/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  bool isLoading = false;
  bool hidePasswordField = false;

  String? email;
  String? password;

  void checkExpire() {
    Timer(const Duration(seconds: 3600), handleTimeout);
  }

  void handleTimeout() {
    AuthHttpServices.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        await _authHttpServices.login(email!, password!);
        checkExpire();

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => const HomeSCreens(),
        //   ),
        // );
        Navigator.pushNamed(context, '/home');
      } on ClientException {
        showDialog(
          context: context,
          builder: (ctx) {
            return const AlertDialog(
              title: Text("Network error"),
              content: Text("Check your internet connection"),
            );
          },
        );
      } catch (e) {
        String message = e.toString();

        if (e.toString().contains("INVALID_LOGIN_CREDENTIALS")) {
          message = "Please check the entered information again";
        }

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Something is wrong"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyText1?.color ?? Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.startScreen);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.h,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(25.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: textColor),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your email";
                    } else {
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Email error";
                      }
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue;
                  },
                ),
                SizedBox(height: 22.h),
                Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextFormField(
                  obscureText: hidePasswordField,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordField = !hidePasswordField;
                        });
                      },
                      icon: Icon(
                        hidePasswordField
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.trim().isEmpty) {
                  //     return "Enter your password";
                  //     //  ! Password upgrade
                  //   } else {
                  //     // Kiritilgan parolni tekshirish uchun regex
                  //     final passwordRegex = RegExp(
                  //         r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#\$%\^&\*])(?=.{8,})');

                  //     if (!passwordRegex.hasMatch(value)) {
                  //       return "Password error: Parol kamida 8 ta belgi, raqam, katta harf va maxsus belgi (\!@\#\$\%\^\&\*) dan iborat bo'lishi kerak";
                  //     }
                  //   }
                  //   // } else {
                  //   //   final passwordRegex = RegExp(r'^[^1234567890]+1234567890[^1234567890]+\.[^1234567890]+');
                  //   //   if (!passwordRegex.hasMatch(value)) {
                  //   //     return "Password error";
                  //   //   }
                  //   // }
                  //   //  ! Password upgrade
                  //   return null;
                  // },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your password";
                    } else {
                      // Probelni olib tashlash
                      value = value.trim();
                      // Kiritilgan parolni tekshirish uchun regex
                      final passwordRegex =
                          RegExp(r'^(?=.*[0-9])(?=.{8,})');
                      // r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#\$%\^&\*])(?=.{8,})');
                      if (!passwordRegex.hasMatch(value)) {
                        return "Password error: Parol kamida 8 ta (\!@\#\$\%\^\&\*) dan iborat bo'lishi kerak";
                      }
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    // save password
                    password = newValue;
                  },
                ),

                // ! Parolni qayta tiklash

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: TextButton(
                //     onPressed: () {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //     builder: (ctx) => const ForgotPasswordScreen(),
                //       //   ),
                //       // );
                //     },
                //     child: const Text(
                //       "Parolni unutdingizmi?",
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 80.h),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            shadowColor: const Color(0xFF8875FF),
                            backgroundColor: const Color(0xFF8875FF),
                          ),
                          onPressed: submit,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),

                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 2.h,
                      width: 140.w,
                      color: Colors.white54,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'or',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      height: 2.h,
                      width: 140.w,
                      color: Colors.white54,
                    ),
                  ],
                ),
                SizedBox(height: 35.h),

                Container(
                  width: double.infinity.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r), // Updated with ScreenUtil
                    ),
                    color: Color(0xFF8875FF),
                    border: Border.all(
                      color: Color(0xFF8875FF),
                    ),
                  ),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF000000),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.r), // Updated with ScreenUtil
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/loginwithgoogleimages.png',
                          height: 25.h, // Updated with ScreenUtil
                          width: 25.w, // Updated with ScreenUtil
                        ),
                        SizedBox(width: 10.w), // Updated with ScreenUtil
                        Text(
                          "Login with Google",
                          style: TextStyle(
                            fontSize: 14.sp, // Updated with ScreenUtil
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r), // Updated with ScreenUtil
                    ),
                    color: Color(0xFF8875FF),
                    border: Border.all(
                      color: Color(0xFF8875FF),
                    ),
                  ),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF000000),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.r), // Updated with ScreenUtil
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/loginwithappleimages.png',
                          height: 30.h, // Updated with ScreenUtil
                          width: 30.w, // Updated with ScreenUtil
                        ),
                        SizedBox(width: 10.w), // Updated with ScreenUtil
                        Text(
                          "Login with Appe",
                          style: TextStyle(
                            fontSize: 14.sp, // Updated with ScreenUtil
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h), // Updated with ScreenUtil
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12.sp, // Updated with ScreenUtil
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).popAndPushNamed(
                                AppRoutes.registerScreen,
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h), // Updated with ScreenUtil
              ],
            ),
          ),
        ),
      ),
    );
  }
}
