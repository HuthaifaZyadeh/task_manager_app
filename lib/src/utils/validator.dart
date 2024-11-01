import '../../generated/locale_keys.g.dart';
import 'extensions.dart';
import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? emailValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.email_validation_message.tr()
        : val.isValidEmail
            ? null
            : LocaleKeys.email_validation_message.tr();
  }

  static String? passwordValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.password_validation_message.tr()
        : val.length > 7
            ? null
            : LocaleKeys.password_validation_message.tr();
  }

  static String? confirmPasswordValidator(String? val,String password) {
    return val == password ? null : "Passwords does not match";
  }

  static String? nameValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.name_validation_message.tr()
        : val.length > 2
            ? null
            : LocaleKeys.name_validation_message.tr();
  }
}
