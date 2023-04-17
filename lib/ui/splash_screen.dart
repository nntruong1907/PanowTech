import 'package:flutter/material.dart';
import 'package:panow_tech/const.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(
              fontFamily: 'SFCompactRounded',
              fontWeight: FontWeight.bold,
              color: primaryCorlor),
        ),
      ),
    );
  }
}
