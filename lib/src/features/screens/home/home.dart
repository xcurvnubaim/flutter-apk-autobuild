import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:welangflood/src/constants/text_string.dart';
import 'package:welangflood/src/features/screens/home/widgets/entri_button.dart';
import 'package:welangflood/src/features/screens/home/widgets/filter.dart';
import 'package:welangflood/src/features/screens/home/widgets/map.dart';
import 'package:welangflood/src/features/screens/home/widgets/text/headline_text.dart';
import 'package:welangflood/src/features/screens/home/widgets/text/subtitle_text.dart';
import 'package:welangflood/src/features/screens/login/login.dart';
import 'package:welangflood/src/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _startDate;
  String? _endDate;

  void _onFilterChanged(String? start, String? end) {
    setState(() {
      _startDate = start;
      _endDate = end;
    });
  }

  Future<void> _handleLogout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              left: screenWidth * 0.065,
              right: screenWidth * 0.065,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FilterButton(onFilterChanged: _onFilterChanged),
                    SizedBox(width: screenWidth * 0.10),
                    const Expanded(child: HeadlineText()),
                    IconButton(
                      icon: const Icon(Icons.logout, color: tPrimaryColor),
                      tooltip: 'Logout',
                      onPressed: _handleLogout,
                    ),
                  ],
                ),

                if (_startDate != null || _endDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_alt, size: 14, color: tSecondaryColor),
                        const SizedBox(width: 4),
                        Text(
                          '${_startDate ?? '...'} → ${_endDate ?? '...'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: tSecondaryColor,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _onFilterChanged(null, null),
                          child: const Icon(Icons.close, size: 14, color: tSecondaryColor),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: screenHeight * 0.04),
                const SubtitleText(text: tEntriSurvei),
                SizedBox(height: screenHeight * 0.01),
                const EntriButton(),

                SizedBox(height: screenHeight * 0.03),
                const SubtitleText(text: tViewPeta),
                SizedBox(height: screenHeight * 0.01),

                SizedBox(
                  height: screenHeight * 0.45,
                  child: ViewMap(
                    startDate: _startDate,
                    endDate: _endDate,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}