import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utils/app_constants.dart';

class OnboardingStep extends StatelessWidget {
  final Image imagesOnboarding;
  final String title;
  final String description;
  final String nextButtonText;
  final String backButtonText;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onBackButtonPressed;

  const OnboardingStep({
    Key? key,
    required this.imagesOnboarding,
    required this.title,
    required this.description,
    required this.nextButtonText,
    required this.backButtonText,
    required this.onNextButtonPressed,
    required this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imagesOnboarding,
          Text(
            title,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: AppConstants.onBoardingTextStyleColor,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppConstants.onBoardingTextStyleColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
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
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                    onPressed: onBackButtonPressed,
                    child: Text(
                      backButtonText,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.r),
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
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                    onPressed: onNextButtonPressed,
                    child: Text(
                      nextButtonText,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
