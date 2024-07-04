// ignore_for_file: unused_import, depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/controllers/user_controller.dart';
import 'package:todo/services/auth_http_services.dart';
import 'package:todo/utils/app_routes.dart';
import 'package:todo/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final usersController = UsersController();

  String? email, password, passwordConfirm;
  bool isLoading = false;

  bool hidePasswordFiled = true;
  bool hideConfirmPasswordField = true;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // register
      setState(() {
        isLoading = true;
      });

      try {
        await _authHttpServices.register(email!, password!);
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        String message = e.toString();

        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "You are registered";
        }

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Attention"),
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.loginScreen);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: 200.w,
                //   height: 200.h,
                //   child: Lottie.asset(Assets.lottiesWriteBlank),
                // ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Email',
                  // 'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.h,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                    // save email
                    email = newValue;
                  },
                ),
                SizedBox(height: 18.h),
                Text(
                  'Password',
                  // 'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextFormField(
                  obscureText: hidePasswordFiled,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "- - - - - - - - - - - - - - - -",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordFiled = !hidePasswordFiled;
                        });
                      },
                      icon: hidePasswordFiled
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter the password";
                    } else if (value.trim().length < 6) {
                      return "The length of the password should not be less than 6";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save password
                    password = newValue;
                  },
                ),
                SizedBox(height: 18.h),
                Text(
                  'Confirm Password',
                  // 'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextFormField(
                  obscureText: hideConfirmPasswordField,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "- - - - - - - - - - - - - - - -",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPasswordField = !hideConfirmPasswordField;
                        });
                      },
                      icon: hideConfirmPasswordField
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter the password";
                    } else if (_passwordConfirmController.text !=
                        _passwordController.text) {
                      return "The password does not match";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    // save password confirm
                    passwordConfirm = newValue;
                  },
                ),
                SizedBox(height: 35.h),
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
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 25.h),
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
                      style: TextStyle(fontSize: 16.sp, color: Colors.white54),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      height: 2.h,
                      width: 140.w,
                      color: Colors.white54,
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Container(
                  width: double.infinity.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
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
                          borderRadius: BorderRadius.circular(5.r),
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
                          height: 28.h,
                          width: 28.w,
                        ),
                        SizedBox(width: 15.h),
                        Text(
                          'Login with Google',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: double.infinity.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                          height: 28.h,
                          width: 28.w,
                        ),
                        SizedBox(width: 15.h),
                        Text(
                          'Login with Apple',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.white54),
                          ),
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const LoginScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
