import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Center(
                  child: RichText(
                      text: TextSpan(
                          text: 'Med',
                          style: const TextStyle(
                              fontFamily: 'Caudex',
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent),
                          children: [
                    TextSpan(
                      text: 'Time',
                      style: const TextStyle(
                          fontFamily: 'Caudex',
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.green),
                    )
                  ]))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'By Farhan S.F',
                  style: TextStyle(fontSize: 16, fontFamily: 'Caudex'),
                ),
              )
            ],
          )),
    );
  }
}
