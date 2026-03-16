import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welangflood/src/features/screens/home/home.dart';
import 'package:welangflood/src/features/screens/login/login.dart';
import 'package:welangflood/src/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if user already has a saved token
  final isLoggedIn = await AuthService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const Home() : const Login(),
    );
  }
}