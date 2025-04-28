import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
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
                        text: 'Reg',
                        style: const TextStyle(
                            fontFamily: 'Caudex',
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                        children: [
                      TextSpan(
                        text: 'ister',
                        style: const TextStyle(
                            fontFamily: 'Caudex',
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: Colors.green),
                      )
                    ])),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: controller.namaController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Username',
                    hintStyle:
                        TextStyle(color: Color(0xFF03071E).withOpacity(0.25)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Email',
                    hintStyle:
                        TextStyle(color: Color(0xFF03071E).withOpacity(0.25)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
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
                            color: Color(0xFF03071E).withOpacity(0.25)),
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
                  height: 10,
                ),
                Text(
                  'Konfirmasi Password',
                  style: TextStyle(fontSize: 16),
                ),
                Obx(
                  () {
                    return TextField(
                      controller: controller.confirmPswdController,
                      obscureText: controller.isConfirmPswdHidden.value,
                      decoration: InputDecoration(
                        hintText: 'Masukkan ulang Password',
                        hintStyle: TextStyle(
                            color: Color(0xFF03071E).withOpacity(0.25)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPswdHidden.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          onPressed: () {
                            controller.isConfirmPswdHidden.value =
                                !controller.isConfirmPswdHidden.value;
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 16,
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
                            await controller.registerUser(
                                controller.namaController.text,
                                controller.emailController.text,
                                controller.passwordController.text,
                                controller.confirmPswdController.text);
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Register",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                  );
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah punya akun?'),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
