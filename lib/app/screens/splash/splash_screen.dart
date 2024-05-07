import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      nextScreenReplace(context, const OnboardScreen());
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBgColor,
      ),
      child: Image.asset('assets/logo/max4u_logo.png'),
    );
  }
}