import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/src/themes/app_colors.dart';

abstract class UIHelper {
  static const double _verticalPadding = 16;
  static const double _horizontalPadding = 20;

  // Vertical spacing constants. Adjust to your liking.
  static final double _verticalSpaceSmall = 10.h;
  static final double _verticalSpaceMedium = 20.h;
  static final double _verticalSpaceLarge = 60.h;

  // Vertical spacing constants. Adjust to your liking.
  static final double _horizontalSpaceSmall = 10.w;
  static final double _horizontalSpaceMedium = 20.w;
  static final double _horizontalSpaceLarge = 60.w;

  static EdgeInsets get pagePadding => REdgeInsets.symmetric(
        vertical: _verticalPadding,
        horizontal: _horizontalPadding,
      );

  static get verticalPagePadding => REdgeInsets.symmetric(
        vertical: _verticalPadding,
      );

  static get horizontalPagePadding => REdgeInsets.symmetric(
        horizontal: _horizontalPadding,
      );

  /// Returns a vertical space with height set to [_verticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return verticalSpace(_verticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_verticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return verticalSpace(_verticalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_verticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_verticalSpaceLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_horizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_horizontalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(_horizontalSpaceLarge);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  static Gradient get gradient => LinearGradient(
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      );

  static Gradient get fromTLToBRgradient => LinearGradient(
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static Gradient get fromTRToBLgradient => LinearGradient(
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
}
