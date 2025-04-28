import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/medicine.dart';
import '../../../helper/db_helper.dart';

class HomeController extends GetxController with StateMixin<List<Medicine>> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userName = ''.obs;
  var foto = ''.obs;
  var db = DbHelper();
  List<Medicine> listMedicines = <Medicine>[].obs;

  TextEditingController search = TextEditingController();

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
      Get.snackbar('Error', 'User tidak ditemukan');
      return;
    }

    firestore.collection('pengguna').doc(userId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        var fullName = data?['username'] ?? 'Nama Tidak Ditemukan';
        var fotoprofile = data?['foto'] ?? '';

        var words = fullName.split(' ');
        userName.value = words.take(2).join(' ');
        foto.value = fotoprofile;
      }
    }, onError: (e) {
      Get.snackbar('Error', 'Gagal mengambil data user: $e,',
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    search.dispose();
  }
}
