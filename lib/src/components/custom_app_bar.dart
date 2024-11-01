import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/src/routing/router.dart';

import '../utils/localization/app_languages.dart';
import '../utils/ui_helper.dart';
import 'app_text.dart';

abstract class CustomAppBar {
  static buildAppBar({
    required String text,
    Widget? titleWidget,
    double titleFontSize = 18,
    double? height,
    Color? titleColor,
    bool centerTitle = true,
    bool showLeading = false,
    bool isHotelSearchResult = false,
    bool isFlightSearchResult = false,
    void Function()? onSearchResultTap,
  }) =>
      AppBar(
        toolbarHeight: isFlightSearchResult ? height : null,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: isFlightSearchResult
            ? titleWidget
            : isHotelSearchResult
                ? InkWell(
                    onTap: onSearchResultTap,
                    child: searchTitle(
                        child: searchTitle(
                      child: AppText(
                        text: text,
                        maxLines: 3,
                        fontSize: 10,
                      ),
                    )),
                  )
                : AppText(
                    text: text,
                    fontSize: titleFontSize,
                    color: titleColor ?? Colors.white,
                  ),
        centerTitle: centerTitle,
        automaticallyImplyLeading: true,
        leading: !showLeading
            ? null
            : IconButton(
                icon: Icon(
                  AppLanguages.isArabic
                      ? FeatherIcons.arrowRight
                      : FeatherIcons.arrowLeft,
                  color: Colors.white,
                ),
                onPressed: () {
                  AppRouter.getRouter.pop();
                },
              ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: UIHelper.gradient),
        ),
      );

  static Widget searchTitle({required Widget child}) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 250.w,
        child: Padding(
          padding: REdgeInsets.all(8.0),
          child: child,
        ),
      );
}
