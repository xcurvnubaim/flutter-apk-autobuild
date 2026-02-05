import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/text_string.dart';
import 'package:welangflood/src/dummy_data/dummy_data.dart';

class HeadlineText extends StatelessWidget {
  const HeadlineText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          tTitleBeranda,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          userDummyData.isNotEmpty ? userDummyData[0]['username'] : 'Username Tidak Ditemukan',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
