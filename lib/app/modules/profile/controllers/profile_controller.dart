import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_remember/app/routes/app_pages.dart';

import '../../../data/medicine.dart';
import '../../../helper/db_helper.dart';

class ProfileController extends GetxController with StateMixin<List<Medicine>> {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhone = ''.obs;
  var userPhoto = ''.obs;
  var selectedGender = 'Laki-laki'.obs;
  var usia = 0.obs;
  var selectedPhoto = XFile('').obs;
  var usernameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var usiaController = TextEditingController().obs;
  var isLoading = true.obs;
  var db = DbHelper();
  List<Medicine> listMedicines = <Medicine>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenToUserData();
    getAllMedicineData();
  }

  void listenToUserData() {
    String? userId = auth.currentUser?.uid;

    if (userId == null) {
      Get.snackbar('Error', 'User tidak ditemukan',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    firestore.collection('pengguna').doc(userId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        userName.value = data?['username'] ?? 'Nama Tidak Ditemukan';
        userEmail.value = data?['email'] ?? 'Email Tidak Ditemukan';
        userPhone.value = data?['telepon'] ?? 'Nomor Telepon Belum Diatur';
        selectedGender.value = data?['gender'] ?? 'Jenis Kelamin Belum Diatur';
        usia.value = data?['usia'] ?? 0;
        userPhoto.value = data?['foto'] ?? '';
        usernameController.value.text = data?['username'] ?? '';
        phoneController.value.text = data?['telepon'] ?? '';
        usiaController.value.text = data?['usia'].toString() ?? '';
      }
    }, onError: (e) {
      Get.snackbar('Error', 'Gagal mengambil data user: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedPhoto.value = XFile(pickedFile.path);
    }
  }

  Future<void> updateProfileWithPhoto() async {
    if (selectedPhoto.value.path.isEmpty) {
      Get.snackbar('Error', 'Foto belum dipilih',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    File imageFile = File(selectedPhoto.value.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    String? userId = auth.currentUser?.uid;

    if (userId == null) {
      Get.snackbar('Error', 'User tidak ditemukan',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    firestore.collection('pengguna').doc(userId).update({
      'foto': base64Image,
      'username': usernameController.value.text,
      'telepon': phoneController.value.text,
      'gender': selectedGender.value,
      'usia': int.parse(usiaController.value.text)
    }).then((value) {
      Get.snackbar('Sukses', 'Profil berhasil diubah',
          backgroundColor: Colors.greenAccent);
      userPhoto.value = base64Image;
    }).catchError((e) {
      Get.snackbar('Error', 'Gagal mengubah profil: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  Future getAllMedicineData() async {
    change(null, status: RxStatus.loading());
    listMedicines.clear();
    final List<Medicine> medicines = await db.queryAllRowsMedicine();
    listMedicines.addAll(medicines);
    if (listMedicines.isEmpty) {
      change(null, status: RxStatus.empty());
    } else {
      change(listMedicines, status: RxStatus.success());
    }
  }

  Future<void> updateProfile() async {
    String? userId = auth.currentUser?.uid;

    if (userId == null) {
      Get.snackbar('Error', 'User tidak ditemukan',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    firestore.collection('pengguna').doc(userId).update({
      'username': usernameController.value.text,
      'telepon': phoneController.value.text,
      'gender': selectedGender.value,
      'usia': int.parse(usiaController.value.text)
    }).then((value) {
      Get.snackbar('Sukses', 'Profil berhasil diubah',
          backgroundColor: Colors.greenAccent);
    }).catchError((e) {
      Get.snackbar('Error', 'Gagal mengubah profil: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.snackbar("Logout", "Anda telah keluar",
          backgroundColor: Colors.greenAccent);
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "Gagal Logout: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
