import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/helpers/cache_helper.dart';
import 'package:task_2/screens/nav/view.dart';

import '../../core/shared/widgets/app_logo.dart';
import '../auth/login/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if(CacheHelper.getUserToken()==''){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LogInScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffD9FFED),
      body: Center(
          child: AppLogo(
            start: 43.r,
            end: 43.r,
          )),
    );
  }
}
