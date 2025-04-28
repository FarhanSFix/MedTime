import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  TextEditingController resetPwdController = TextEditingController();
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      if (email.isEmpty) {
        Get.snackbar(
          'Error',
          'Email tidak boleh kosong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (email != "" && GetUtils.isEmail(email)) {
        await auth.sendPasswordResetEmail(email: email);
        Get.snackbar(
          'Berhasil',
          'Password reset link telah dikirim ke email anda',
          backgroundColor: Colors.greenAccent,
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          'Error',
          'Masukkan email yang valid',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal Mereset Password ${e}",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    resetPwdController.dispose();
    super.onClose();
  }
}
