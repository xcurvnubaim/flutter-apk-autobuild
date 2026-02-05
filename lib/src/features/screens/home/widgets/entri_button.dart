import 'package:flutter/material.dart';
import 'package:welangflood/src/common_widets/filled%20button/button.dart';
import 'package:welangflood/src/common_widets/transition/transition.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:welangflood/src/constants/text_string.dart';
import 'package:welangflood/src/features/screens/entri/entri_survei.dart';

class EntriButton extends StatelessWidget {
  const EntriButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth < 375.0 ? constraints.maxWidth : 375.0;

        return Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tPrimaryColor),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.0427,
            vertical: screenSize.height * 0.0266,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.file_copy,
                      size: screenSize.width * 0.064,
                      color: tPrimaryColor,
                    ),

                    SizedBox(width: screenSize.width * 0.0373),
                    Expanded(
                      child: Text(
                        tEntriTitle,
                        style: TextStyle(
                          color: tPrimaryColor,
                          fontFamily: 'Inter',
                          fontSize: screenSize.width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenSize.height * 0.0213),
                CustomElevatedButton(
                  height: screenSize.height * 0.055,
                  onPressed: () {
                    TransitionUtils.navigateWithFadeTransition(context, const EntriSurvei());
                  },
                  text: tEntriButton,
                  foregroundColor: tTertiaryColor,
                  backgroundColor: tPrimaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
