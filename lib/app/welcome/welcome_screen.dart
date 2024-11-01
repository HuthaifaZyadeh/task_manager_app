import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_do/src/core/data_sources/local/local_storage.dart';
import 'package:simple_do/src/di/services_locator.dart';

import '../../src/routing/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2700),
    ).then(_navigate);
  }

  Future _navigate(_) async {
    if (getIt<LocalStorage>().appUser == null) {
      context.go(Routes.login);
    } else {
      context.go(Routes.tasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello!",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            20.verticalSpace,
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome back',
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              pause: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}
