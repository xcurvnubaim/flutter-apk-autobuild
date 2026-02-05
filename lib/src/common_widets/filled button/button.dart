import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final Widget? icon;
  final Alignment iconPosition;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.foregroundColor,
    required this.backgroundColor,
    this.height,
    this.width,
    this.fontSize,
    this.icon,
    this.iconPosition = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = 375.0;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: backgroundColor),
        padding: const EdgeInsets.symmetric(vertical: 0.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width ?? maxWidth,
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && iconPosition == Alignment.centerLeft) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
              ],
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: fontSize ?? 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              if (icon != null && iconPosition == Alignment.centerRight) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: icon,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
