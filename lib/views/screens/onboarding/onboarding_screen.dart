import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_routes.dart';
import 'package:todo/views/screens/onboarding/onboarding_step.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.startScreen);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _skipOnboarding() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.startScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextButton(
          onPressed: _skipOnboarding,
          child: Text(
            'SKIP',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppConstants.appBarskipColor,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          OnboardingStep(
            imagesOnboarding: Image.asset('assets/images/manageyourtasks.png',
                width: double.infinity, height: 300.h),
            title: "Manage your tasks",
            description:
                "You can easily manage all of your daily\ntasks in DoMe for free",
            nextButtonText: "NEXT",
            backButtonText: "BACK",
            onNextButtonPressed: _nextPage,
            onBackButtonPressed: _previousPage,
          ),
          OnboardingStep(
            imagesOnboarding: Image.asset(
                'assets/images/onboardingstepimage.png',
                width: double.infinity,
                height: 300.h),
            title: "Create daily routine",
            description:
                "In UpTodo you can create your\npersonalized routine to stay productive",
            nextButtonText: "NEXT",
            backButtonText: "BACK",
            onNextButtonPressed: _nextPage,
            onBackButtonPressed: _previousPage,
          ),
          OnboardingStep(
            imagesOnboarding: Image.asset('assets/images/onboardingimages.png',
                width: double.infinity, height: 300.h),
            title: "Organize your tasks",
            description:
                "You can organize your daily tasks by\nadding your tasks into separate categories",
            nextButtonText: "GET STARTED",
            backButtonText: "BACK",
            onNextButtonPressed: _nextPage,
            onBackButtonPressed: _previousPage,
          ),
        ],
      ),
    );
  }
}
