import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:simple_do/src/components/phone_text_field/phone_text_field.dart';

import '../../generated/locale_keys.g.dart';
import '../themes/app_colors.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({
    super.key,
    this.onChanged,
    this.initValue,
    this.suffix,
    this.isDisabled = false,
  });

  final void Function(PhoneNumber)? onChanged;
  final String? initValue;
  final Widget? suffix;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.textFieldBg,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Directionality(
        textDirection: mat.TextDirection.ltr,
        child: PhoneTextField(
          locale: const Locale('en'),
          initialValue: initValue,
          readOnly: isDisabled,
          showCountryCodeAsIcon: true,
          autovalidateMode: AutovalidateMode.disabled,
          decoration: buildInputDecoration(),
          searchFieldInputDecoration: buildSearchInputDecoration(),
          initialCountryCode: "+965",
          invalidNumberMessage: LocaleKeys.phone_validation_message.tr(),
          onChanged: (phone) {
            debugPrint(phone.countryISOCode);
            if (onChanged != null) onChanged!(phone);
          },
        ),
      ),
    );
  }

  InputDecoration buildSearchInputDecoration() {
    return InputDecoration(
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Color(0xFFECECEC)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Color(0xFFECECEC)),
      ),
      suffixIcon: const Icon(Icons.search),
      hintText: LocaleKeys.search_country.tr(),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.textFieldBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Color(0xFFECECEC)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Color(0xFFECECEC)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Color(0xFFECECEC)),
      ),
      border: InputBorder.none,
      suffixIcon: suffix,
      hintText: LocaleKeys.phone_number.tr(),
      hintStyle: TextStyle(
        color: AppColors.disabled,
      ),
    );
  }
}
