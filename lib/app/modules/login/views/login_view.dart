import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Log',
                          style: const TextStyle(
                              fontFamily: 'Caudex',
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent),
                          children: [
                        TextSpan(
                          text: 'In',
                          style: const TextStyle(
                              fontFamily: 'Caudex',
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.green),
                        )
                      ])),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email atau Username',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email atau Username',
                      hintStyle: TextStyle(
                          color: const Color(0xFF03071E).withOpacity(0.25)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(
                    () {
                      return TextField(
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password',
                          hintStyle: TextStyle(
                              color: const Color(0xFF03071E).withOpacity(0.25)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            onPressed: () {
                              controller.isPasswordHidden.value =
                                  !controller.isPasswordHidden.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.RESET_PASSWORD),
                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Color(0xFFFFFFFF),
                        minimumSize: Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.login(controller.emailController.text,
                                controller.passwordController.text);
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator()
                        : Text("Masuk",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.40.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun? ",
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.REGISTER),
                          child: Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
