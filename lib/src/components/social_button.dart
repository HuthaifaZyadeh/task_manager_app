import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/app_colors.dart';
import '../themes/app_icons.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.type, this.onTap});

  final int type;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return buildSocialButton(type);
  }

  Widget buildSocialButton(int index) {
    String icon;
    switch (index) {
      case 0:
        icon = AppIcons.facebook;
        break;
      case 1:
        icon = AppIcons.google;
        break;
      case 2:
        icon = AppIcons.apple;
        break;
      default:
        icon = AppIcons.google;
    }
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.disabled),
          ),
          height: 50.h,
          width: 50.h,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}
