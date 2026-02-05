import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: TextStyle(
        color: tPrimaryColor,
        fontSize: screenWidth * 0.045,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
