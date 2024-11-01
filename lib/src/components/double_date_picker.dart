// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/double_date_picker_mode.dart';
import '../themes/app_colors.dart';
import '../utils/localization/app_languages.dart';
import '../utils/ui_helper.dart';
import 'app_text.dart';
import 'custom_date_time_picker.dart';

class DoubleDatePicker extends StatefulWidget {
  const DoubleDatePicker({
    super.key,
    this.mode = DoubleDatePickerMode.date,
    required this.firstDateTitle,
    required this.secondDateTitle,
    required this.onFirstDatePicked,
    required this.onSecondDatePicked,
    this.defaultFirstDate,
    this.defaultSecondDate,
    this.showSecond = false,
    this.showDuration = true,
  });

  final DoubleDatePickerMode mode;
  final String firstDateTitle;
  final String secondDateTitle;
  final DateTime? defaultFirstDate;
  final DateTime? defaultSecondDate;
  final bool showSecond;
  final bool showDuration;
  final void Function(DateTime?) onFirstDatePicked;
  final void Function(DateTime?) onSecondDatePicked;

  @override
  State<DoubleDatePicker> createState() => _DoubleDatePickerState();
}

class _DoubleDatePickerState extends State<DoubleDatePicker> {
  DateTime? firstDate, secondDate;
  DateFormat dateFormat =
      DateFormat('EEE, d/MMM/yy', AppLanguages.getCurrentLocale.languageCode);
  DateFormat timeFormat =
      DateFormat('hh:mm aa', AppLanguages.getCurrentLocale.languageCode);
  String notPickedValue = '---';

  @override
  void initState() {
    if (widget.defaultFirstDate != null) {
      firstDate = widget.defaultFirstDate;
    }
    if (widget.defaultSecondDate != null) {
      secondDate = widget.defaultSecondDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildDateRow();
  }

  Widget buildDateRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDateColumn(
              title: widget.firstDateTitle,
              date: firstDate == null
                  ? notPickedValue
                  : getDateByMode(firstDate!),
              onDatePicked: (date) {
                if (date != null) {
                  setState(() {
                    firstDate = date;
                    secondDate = null;
                    widget.onSecondDatePicked(null);
                    widget.onFirstDatePicked(date);
                  });
                }
              },
            ),
            if (widget.showSecond) ...[
              buildDurationDivider(),
              buildDateColumn(
                title: widget.secondDateTitle,
                isSecondDate: true,
                date: secondDate == null
                    ? notPickedValue
                    : getDateByMode(secondDate!),
                onDatePicked: (date) {
                  if (date != null) {
                    setState(() {
                      secondDate = date;
                      widget.onSecondDatePicked(date);
                    });
                  }
                },
              ),
            ]
          ],
        ),
        const Divider(),
      ],
    );
  }

  String getDateByMode(DateTime firstDate) {
    return widget.mode == DoubleDatePickerMode.date
        ? dateFormat.format(firstDate)
        : '${dateFormat.format(firstDate)}\n${timeFormat.format(firstDate)}';
  }

  SizedBox buildDurationDivider() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 16.w,
            height: 2.h,
          ),
          if (firstDate != null && secondDate != null && widget.showDuration)
            Padding(
              padding: REdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.textFieldBg,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: AppText(
                    text:
                        "${secondDate!.difference(firstDate!).inDays} days${widget.mode == DoubleDatePickerMode.date ? '' : '\n${secondDate!.difference(firstDate!).inHours.remainder(24)} hours\n${secondDate!.difference(firstDate!).inMinutes.remainder(60)} min'}",
                    fontSize: 10,
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          const SizedBox(
            width: 1,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget buildDateColumn({
    required String title,
    required String date,
    required Function(DateTime?) onDatePicked,
    bool isSecondDate = false,
  }) {
    return IgnorePointer(
      ignoring: isSecondDate && firstDate == null,
      child: InkWell(
        onTap: () {
          if (widget.mode == DoubleDatePickerMode.dateTime) {
            showCustomDateTimePicker(
              context: context,
              minimumDate: isSecondDate ? firstDate! : DateTime.now(),
              initialDateTime: isSecondDate ? secondDate : firstDate,
            ).then((value) {
              onDatePicked(value);
            });
          } else {
            showDatePicker(
              context: context,
              initialDate: isSecondDate ? secondDate : firstDate,
              firstDate: isSecondDate ? firstDate! : DateTime.now(),
              lastDate: DateTime.now().copyWith(year: 2034),
            ).then((value) {
              onDatePicked(value);
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  FeatherIcons.calendar,
                  color: AppColors.disabled,
                ),
                UIHelper.horizontalSpaceSmall(),
                AppText(
                  text: title,
                  fontSize: 12,
                  color: AppColors.disabled,
                ),
              ],
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: date,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
