import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Reset ',
                        style: const TextStyle(
                            fontFamily: 'Caudex',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                        children: [
                      TextSpan(
                        text: 'Password',
                        style: const TextStyle(
                            fontFamily: 'Caudex',
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.green),
                      )
                    ])),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  'Masukkan Email yang valid',
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: controller.resetPwdController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan email',
                    hintStyle:
                        TextStyle(color: Color(0xFF03071E).withOpacity(0.25)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Color(0xFFFFFFFF),
                        minimumSize: Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            controller.resetPassword(
                                controller.resetPwdController.text);
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Reset",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                  );
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
