import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../themes/app_colors.dart';

class PaginationIndicator extends StatelessWidget {
  const PaginationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.primary,
        size: 50.r,
      ),
    );
  }
}
