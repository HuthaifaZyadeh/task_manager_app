import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.width,
    this.height,
    this.controller,
    this.hint,
    this.label,
    this.suffixIcon,
    this.initialValue,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.isDisabled = false,
    this.isMultiline = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onChanged,
  });

  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool isDisabled;
  final bool isMultiline;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPassword = false;

  @override
  void initState() {
    _isPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        focusNode: widget.focusNode,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        initialValue: widget.initialValue,
        obscureText: _isPassword,
        validator: widget.validator,
        readOnly: widget.isDisabled,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        maxLines: widget.isMultiline ? null : widget.maxLines,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBg),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBg),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(8)),
          hintText: widget.hint,
          labelText: widget.label,
          hintStyle: TextStyle(
            color: AppColors.disabled,
          ),
          filled: true,
          fillColor: AppColors.textFieldBg,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFECECEC)),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: widget.isPassword ? secureWidget : widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }

  Widget get secureWidget => IconButton(
      onPressed: () {
        setState(() {
          _isPassword = !_isPassword;
        });
      },
      icon: _isPassword
          ? const Icon(FeatherIcons.eyeOff)
          : const Icon(FeatherIcons.eye));
}

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    super.key,
    required this.title,
    required this.widget,
    this.required = false,
  });

  final String title;
  final Widget widget;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            title,
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
      widget,
    ]
        // .addSpaces(height: 8.h).toList(),
        );
  }
}

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget({
    super.key,
    this.controller,
    this.prefix,
    this.hideText = false,
    this.onSubmit,
    this.width,
    this.onChanged,
    this.label,
    this.hintText,
    this.secure = false,
    this.validator,
    this.prefixConstraint,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.suffixIcon,
    this.initialValue,
    this.enabled,
    this.maxLines = 1,
    this.isMultiline = false,
  }) : assert(secure == false || suffixIcon == null);

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? prefix;
  bool hideText;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final double? width;
  final String? label;
  final bool secure;
  final bool? enabled;
  final bool isMultiline;
  final String? Function(String?)? validator;
  final BoxConstraints? prefixConstraint;
  final TextAlign textAlign;
  final int? maxLength;
  final int maxLines;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? suffixIcon;
  final String? initialValue;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        onFieldSubmitted: widget.onSubmit,
        controller: widget.controller,
        obscureText: widget.hideText,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        maxLines: widget.isMultiline ? null : widget.maxLines,
        textAlign: widget.textAlign,
        validator: widget.validator,
        inputFormatters: [
          ...?widget.inputFormatters,
          if (widget.keyboardType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          // hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.dark),
          prefixIcon: widget.prefix,
          prefixIconConstraints: widget.prefixConstraint,
          labelText: widget.label,
          // labelStyle: textTheme.bodyLarge?.copyWith(color: AppColors.dark),
          suffixIcon: widget.secure ? secureWidget : widget.suffixIcon,
        ));
    // .size(w: widget.width);
  }

  Widget get secureWidget => IconButton(
      onPressed: () {
        setState(() {
          widget.hideText = !widget.hideText;
        });
      },
      icon: widget.hideText
          ? const Icon(FeatherIcons.eyeOff)
          : const Icon(FeatherIcons.eye));
}
