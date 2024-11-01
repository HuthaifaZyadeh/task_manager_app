import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/src/utils/localization/app_languages.dart';
import 'package:simple_do/src/utils/localization/app_locales.dart';
import '../generated/codegen_loader.g.dart';
import '../src/routing/router.dart';
import '../src/themes/app_theme.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [arabicLocale, englishLocale],
      path: 'assets/i18n',
      fallbackLocale: englishLocale,
      startLocale: AppLanguages.getCurrentLocale,
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: appSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (
            BuildContext context,
            Widget? child,
          ) =>
              MaterialApp.router(
            title: 'SimpleDo',
            theme: appTheme,
            builder: BotToastInit(),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routerConfig: AppRouter.getRouter,
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    );
  }
}
