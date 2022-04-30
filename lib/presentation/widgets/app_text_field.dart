import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

enum TextFieldType {
  email,
  password,
  normal,
  number,
}

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? counterText;
  final String? labelText;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool? autoFocus;
  final bool? autoCorrect;
  final bool? roundBorder;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextFieldType textFieldType;
  final bool obscurePassword;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;

  const AppTextField({
    Key? key,
    this.controller,
    this.validator,
    this.hintText,
    this.icon,
    this.autoFocus,
    this.maxLines,
    this.keyboardType,
    this.margin,
    this.padding,
    this.textFieldType = TextFieldType.normal,
    this.obscurePassword = true,
    this.onSuffixIconPressed,
    this.inputFormatters,
    this.labelText,
    this.onChanged,
    this.autoCorrect,
    this.suffixIcon,
    this.roundBorder,
    this.textAlign,
    this.maxLength,
    this.minLines,
    this.counterText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _padding = EdgeInsets.symmetric(
      horizontal: ResponsiveValue(
        context,
        defaultValue: 100.0,
        valueWhen: const [
          Condition.smallerThan(name: MOBILE, value: 10.0),
          Condition.smallerThan(name: TABLET, value: 25.0),
        ],
      ).value!,
    );
    const _margin = EdgeInsets.symmetric(vertical: 15);
    switch (textFieldType) {
      case TextFieldType.email:
        return Container(
          padding: padding ?? _padding,
          margin: margin ?? _margin,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            autocorrect: false,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: validator,
            textAlign: textAlign ?? TextAlign.center,
            decoration: InputDecoration(
              labelText: labelText ?? 'Email',
              hintText: hintText ?? 'abc@email.com',
              counterText: counterText,
              prefixIcon: const Icon(Icons.mail),
              suffixIcon: controller == null //if controller is not given
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onSuffixIconPressed,
                    )
                  : controller!.text
                          .isEmpty //only if controller is given and textfield is not empty
                      ? Container(width: 0)
                      : onSuffixIconPressed ==
                              null //if the onSuffixIconPressed function is not given
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => controller!.clear(),
                            )
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                controller!.clear();
                                onSuffixIconPressed!();
                              },
                            ),
              focusedBorder: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
          ),
        );

      case TextFieldType.password:
        return Container(
          padding: padding ?? _padding,
          margin: margin ?? _margin,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: validator,
            autocorrect: false,
            textAlign: textAlign ?? TextAlign.center,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: labelText ?? 'Password',
              hintText: hintText ?? 'pAssWord1@',
              counterText: counterText,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: obscurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: onSuffixIconPressed,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
          ),
        );

      case TextFieldType.number:
        return Container(
          padding: padding ?? _padding,
          margin: margin ?? _margin,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: validator,
            autocorrect: false,
            textAlign: textAlign ?? TextAlign.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: labelText ?? 'Numbers',
              hintText: hintText ?? '123',
              counterText: counterText,
              alignLabelWithHint: true,
              hintStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
              prefixIcon: icon != null ? Icon(icon) : null,
              suffixIcon: suffixIcon == null
                  ? null
                  : IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixIconPressed,
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
          ),
        );

      default:
        return Container(
          padding: padding ?? _padding,
          margin: margin ?? _margin,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            autocorrect: autoCorrect ?? false,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: validator,
            textAlign: textAlign ?? TextAlign.center,
            inputFormatters: [...?inputFormatters],
            decoration: InputDecoration(
              counterText: counterText,
              labelText: labelText,
              hintText: hintText,
              alignLabelWithHint: true,
              hintStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
              prefixIcon: icon != null ? Icon(icon) : null,
              suffixIcon: suffixIcon == null
                  ? null
                  : IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixIconPressed,
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: roundBorder ?? true
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
          ),
        );
    }
  }
}
