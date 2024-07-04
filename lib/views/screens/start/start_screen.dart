import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utils/app_routes.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.onboardingScreen);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.h,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 10.h),
          Column(
            children: [
              Text(
                'Welcome to UpTodo',
                style: TextStyle(
                  fontSize: 28.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            'Please login to your account or create\nnew account to continue',
            style: TextStyle(
              fontSize: 15.h,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 320.h),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Color(0xFF8875FF),
                  ),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF8875FF),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity.w,
                  height: 50.h,
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
                    child: Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
