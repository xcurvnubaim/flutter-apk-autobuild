import 'package:flutter/material.dart';
import 'package:welangflood/src/common_widets/transition/transition.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:welangflood/src/constants/text_string.dart';
import 'package:welangflood/src/features/screens/home/home.dart';

class LupaKataSandiText extends StatelessWidget {
  final Size screenSize;
  const LupaKataSandiText({Key? key, required this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TransitionUtils.navigateWithFadeTransition(context, const Home());
      },
      child: Padding(
        padding: EdgeInsets.only(left: screenSize.width * 0.58),
        child: Text(
          tLupaLogin,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: screenSize.width * 0.035,
            fontWeight: FontWeight.normal,
            color: tPrimaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
