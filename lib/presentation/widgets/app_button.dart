import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  const AppButton({
    Key? key,
    required this.name,
    required this.onPressed,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        child: Text(name),
        style: ElevatedButton.styleFrom(
          primary: color ?? Theme.of(context).primaryColor,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
          alignment: alignment,
          textStyle: TextStyle(
            fontSize: ResponsiveValue(
              context,
              defaultValue: 20.0,
              valueWhen: const [
                Condition.smallerThan(
                  name: MOBILE,
                  value: 15.0,
                ),
                Condition.largerThan(
                  name: TABLET,
                  value: 25.0,
                )
              ],
            ).value,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
