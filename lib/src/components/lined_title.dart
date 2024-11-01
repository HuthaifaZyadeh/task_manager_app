import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import 'app_text.dart';

class LinedTitle extends StatelessWidget {
  const LinedTitle({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildLine(),
        AppText(
          text: text,
          color: AppColors.disabled,
        ),
        buildLine(),
      ],
    );
  }

  Container buildLine() {
    return Container(
      color: AppColors.disabled,
      width: 100.w,
      height: 1.h,
    );
  }
}
