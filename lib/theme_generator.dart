import 'package:flutter/material.dart';
import 'constants/global_constants.dart';

class ThemeGenerator {
  static ThemeData generateThemeData() {
    return ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kScaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // primarySwatch: Color(0xFF333333),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
      ),
      buttonTheme: _getButtonThemeData(),
      dividerTheme: _getDividerThemeData(),
      checkboxTheme: _getCheckboxThemeData(),
    );
  }

  static DividerThemeData _getDividerThemeData() {
    return const DividerThemeData().copyWith(
      space: 40,
      thickness: 1.5,
      indent: 10,
      endIndent: 10,
      color: Colors.grey,
    );
  }

  static ButtonThemeData _getButtonThemeData() {
    return const ButtonThemeData().copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textTheme: ButtonTextTheme.primary,
    );
  }

  static CheckboxThemeData _getCheckboxThemeData() {
    return const CheckboxThemeData().copyWith(
      checkColor: MaterialStateProperty.all<Color>(kWhiteColor),
      fillColor: MaterialStateProperty.all<Color>(kSecondaryColor),
    );
  }
}
