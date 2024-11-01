import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/extensions.dart';

ThemeData get appTheme => ThemeData(
      primarySwatch: AppColors.primary.toMaterialColor(),
      brightness: Brightness.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:
          const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
    );

TextTheme get textTheme => TextTheme(
      displayLarge: TextStyle(
        fontSize: 38.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.primary,
      ),
    );

Size get appSize => const Size(375, 812);
