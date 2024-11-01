import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.overFlow,
  });

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overFlow,
    );
  }

  static String? get fontFamily => GoogleFonts.poppins().fontFamily;
}
