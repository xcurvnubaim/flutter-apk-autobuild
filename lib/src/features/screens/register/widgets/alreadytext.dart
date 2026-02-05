import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';

class CustomRichText extends StatelessWidget {
  final VoidCallback onPressed;
  final String alreadyText;
  final String signText;

  const CustomRichText({
    Key? key,
    required this.onPressed,
    required this.alreadyText,
    required this.signText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize = screenWidth * 0.035;

    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onPressed,
        child: Text.rich(
          TextSpan(
            text: alreadyText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: tPrimaryColor,
            ),
            children: [
              TextSpan(
                text: signText,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: tPrimaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
