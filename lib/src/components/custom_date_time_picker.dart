import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routing/router.dart';
import '../themes/app_colors.dart';
import '../utils/ui_helper.dart';
import 'app_text.dart';

Future<DateTime?> showCustomDateTimePicker({
  required BuildContext context,
  DateTime? initialDateTime,
  DateTime? minimumDate,
  DateTime? maximumDate,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
}) {
  DateTime? dateTime;
  return showDialog<DateTime?>(
    context: context,
    builder: (ctx) => Dialog(
      child: SizedBox(
        height: 370.h,
        child: Column(
          children: [
            SizedBox(
              height: 300.h,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: CupertinoDatePicker(
                  mode: mode,
                  dateOrder: DatePickerDateOrder.dmy,
                  maximumDate: maximumDate,
                  minimumDate: minimumDate,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (value) {
                    dateTime = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: UIHelper.horizontalPagePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      AppRouter.getRouter.pop(null);
                    },
                    child: const AppText(text: 'Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      AppRouter.getRouter.pop(dateTime ?? DateTime.now());
                    },
                    child: AppText(
                      text: 'Done',
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
