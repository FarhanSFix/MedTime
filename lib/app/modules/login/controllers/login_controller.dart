import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Rx<User?> firebaseUser = Rx<User?>(null);
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login(String usernameOrEmail, String password) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      if (usernameOrEmail.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Username/Email dan Password tidak boleh kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      String email = usernameOrEmail;
      if (!usernameOrEmail.contains("@")) {
        QuerySnapshot querySnapshot = await firestore
            .collection('pengguna')
            .where('username', isEqualTo: usernameOrEmail)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          email = querySnapshot.docs.first['email'];
        } else {
          Get.snackbar(
            'Error',
            'Username tidak ditemukan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user!.emailVerified) {
        Get.snackbar('Sukses', 'Pengguna berhasil masuk',
            backgroundColor: Colors.greenAccent);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'Error',
          'Tolong verifikasi email Anda terlebih dahulu',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Error',
          'Email atau password salah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Error',
          'Terlalu banyak percobaan login. Coba lagi nanti',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Terjadi kesalahan. Coba lagi nanti',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
