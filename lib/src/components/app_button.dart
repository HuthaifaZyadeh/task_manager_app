import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.disabled = false,
    this.isOutlined = false,
    this.isLoading = false,
    this.height = 50,
    this.width = 200,
    this.icon,
  });

  const AppButton.outlined({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.disabled = false,
    this.isOutlined = true,
    this.isLoading = false,
    this.height = 50,
    this.width = 200,
    this.icon,
  });

  final String title;
  final Color? textColor;
  final Color? bgColor;
  final void Function()? onPressed;
  final bool disabled;
  final bool isOutlined;
  final bool isLoading;
  final double height;
  final double width;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: isLoading
            ? () {}
            : disabled
                ? null
                : onPressed,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(1),
          backgroundColor: WidgetStateProperty.all(disabled
              ? AppColors.lightest
              : isOutlined
                  ? AppColors.white
                  : bgColor ?? AppColors.primary),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                color: disabled
                    ? AppColors.lightest
                    : isOutlined
                        ? textColor ?? AppColors.primary
                        : bgColor ?? AppColors.primary,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 8),
          child: isLoading
              ? SizedBox(
                  height: height.h,
                  width: height.h,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                        strokeWidth: 3, backgroundColor: AppColors.white),
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon!,
                        4.horizontalSpace,
                        Text(
                          title,
                          style: textTheme.labelLarge!.copyWith(
                            color: isOutlined
                                ? textColor ?? AppColors.primary
                                : textColor ?? AppColors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: textTheme.labelLarge!.copyWith(
                        color: disabled
                            ? AppColors.blackShadow
                            : isOutlined
                                ? textColor ?? AppColors.primary
                                : textColor ?? AppColors.white,
                      ),
                    ),
        ),
      ),
    );
  }
}
