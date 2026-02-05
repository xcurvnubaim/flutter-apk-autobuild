import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';

class Headline extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double? fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  const Headline({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize,
    this.color = tPrimaryColor,
    this.fontFamily = 'Inter',
    this.fontWeight = FontWeight.w700,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveFontSize = fontSize ?? screenWidth * 0.06;

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: responsiveFontSize,
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
