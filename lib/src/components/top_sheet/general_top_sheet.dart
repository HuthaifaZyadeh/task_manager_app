import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/src/components/app_text.dart';
import 'package:simple_do/src/utils/ui_helper.dart';

showTopSheet(
  context, {
  required Widget child,
  required String title,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, _, __) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: UIHelper.pagePadding.copyWith(top: 24.r),
                color: Colors.white,
                alignment: Alignment.center,
                child: AppText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: UIHelper.pagePadding,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )),
              child: Material(child: child),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
}
