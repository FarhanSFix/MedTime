import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPswdController = TextEditingController();
  var isPasswordHidden = true.obs;
  var isConfirmPswdHidden = true.obs;
  var isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String username, String email, String password,
      String confirmPassword) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      if (username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        Get.snackbar(
          'Error',
          'Seluruh kolom harus diisi!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (password != confirmPassword) {
        Get.snackbar(
          "Error",
          "Password dan konfirmasi password tidak sesuai.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      try {
        QuerySnapshot usernameCheck = await firestore
            .collection('pengguna')
            .where('username', isEqualTo: username)
            .get();

        if (usernameCheck.docs.isNotEmpty) {
          Get.snackbar(
            "Error",
            "Username sudah digunakan.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await firestore
            .collection('pengguna')
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
        await userCredential.user!.sendEmailVerification();
        Get.snackbar("Sukses", "Pengguna berhasil didaftarkan.",
            backgroundColor: Colors.greenAccent);
        Get.defaultDialog(
          title: 'Verifikasi email anda',
          middleText:
              'Tolog verifikasi email anda dengan mengklik link yang kami kirimkan ke email anda.',
          textConfirm: 'OK',
          textCancel: 'Resend',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          onCancel: () async {
            await userCredential.user!.sendEmailVerification();
            Get.snackbar(
              'Sukses',
              'Email verifikasi berhasil dikirim.',
              backgroundColor: Colors.greenAccent,
            );
          },
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Registrasi gagal: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Registrasi Gagal $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPswdController.dispose();
    super.onClose();
  }
}
