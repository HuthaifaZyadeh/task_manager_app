import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_do/src/core/data_sources/local/local_storage.dart';
import 'package:simple_do/src/di/services_locator.dart';

import '../../../../src/components/app_text.dart';
import '../../../../src/components/custom_cached_image.dart';
import '../../../../src/routing/routes.dart';
import '../../../../src/themes/app_colors.dart';

class TasksAppBar extends StatelessWidget {
  const TasksAppBar({super.key, required this.userImage});

  final String userImage;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.h,
      backgroundColor: AppColors.primary,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: CustomCachedImage(
          url: userImage,
          color: AppColors.white,
          boxFit: BoxFit.scaleDown,
        ),
        titlePadding: EdgeInsets.zero,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    getIt<LocalStorage>()
                      ..clearAppUser()
                      ..clearToken();
                    context.go(Routes.login);
                  },
                  icon: const Icon(Icons.logout),
                  color: AppColors.white,
                  iconSize: 20.sp,
                ),
              ],
            ),
            AppText(
              text: 'My Tasks',
              fontSize: 20,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
