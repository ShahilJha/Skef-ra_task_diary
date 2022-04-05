import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

enum TextFieldType {
  email,
  password,
  normal,
}

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? icon;
  final bool? autoFocus;
  final int? maxLines;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextFieldType textFieldType;
  final bool? obscurePassword;
  final VoidCallback? togglePassword;
  final List<TextInputFormatter>? inputFormatters;

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
    this.obscurePassword,
    this.togglePassword,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (textFieldType) {
      case TextFieldType.email:
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveValue(
            context,
            defaultValue: 100.0,
            valueWhen: const [
              Condition.smallerThan(name: MOBILE, value: 10.0),
              Condition.smallerThan(name: TABLET, value: 25.0),
            ],
          ).value!),
          margin: margin ?? const EdgeInsets.symmetric(vertical: 25),
          child: TextFormField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: validator,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(Icons.mail),
              suffixIcon: controller!.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => controller!.clear(),
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        );

      case TextFieldType.password:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveValue(
              context,
              defaultValue: 100.0,
              valueWhen: const [
                Condition.smallerThan(name: MOBILE, value: 10.0),
                Condition.smallerThan(name: TABLET, value: 25.0),
              ],
            ).value!,
          ),
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: validator,
            textAlign: TextAlign.center,
            obscureText: obscurePassword!,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                icon: obscurePassword!
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: togglePassword,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        );

      default:
        return Container(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: ResponsiveValue(
                  context,
                  defaultValue: 100.0,
                  valueWhen: const [
                    Condition.smallerThan(name: MOBILE, value: 10.0),
                    Condition.smallerThan(name: TABLET, value: 25.0),
                    // Condition.largerThan(name: TABLET, value: 100.0),
                  ],
                ).value!,
              ),
          margin: margin ?? const EdgeInsets.symmetric(vertical: 25),
          child: TextFormField(
            autofocus: autoFocus ?? false,
            maxLines: maxLines,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: validator,
            textAlign: TextAlign.center,
            inputFormatters: [...?inputFormatters],
            decoration: InputDecoration(
              hintText: hintText,
              alignLabelWithHint: true,
              hintStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
              prefixIcon: icon != null ? Icon(icon) : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
    }
  }
}
