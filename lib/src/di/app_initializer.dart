import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/phone_text_field/helper/countries.dart';
import '../utils/custom_bloc_observer.dart';
import 'services_locator.dart';
import '../routing/router.dart';

abstract class AppInitializer {
  static init() async {
    ///because binding should be initialized before calling runApp.
    WidgetsFlutterBinding.ensureInitialized();

    /// observing on create ,edit and delete cubits
    Bloc.observer = CustomBlocObserver();

    /// loading .env file
    await dotenv.load(fileName: '.env');

    ///initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    /// Setup for phone number field
    CountriesHelper.init(const Locale('en').languageCode.toLowerCase());

    ///initialize routing
    AppRouter.init();

    ///dependencies injection
    await ServicesLocator.setup();

    /// To fix texts being hidden bug in flutter_screenutil in release mode.
    await ScreenUtil.ensureScreenSize();
  }
}
