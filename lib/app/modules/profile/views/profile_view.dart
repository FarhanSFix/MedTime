import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Caudex'),
                ),
                const SizedBox(height: 40),
                CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  radius: 72.5,
                  child: controller.userPhoto.value.isNotEmpty
                      ? Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(controller.userPhoto.value),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.blue,
                        ),
                ),
                const SizedBox(height: 24),
                Text(
                  controller.userName.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userEmail.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userPhone.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.selectedGender.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.usia.value.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            barrierDismissible: false,
                            AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: const Text(
                                "Edit Profile",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: controller.pickImage,
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Obx(
                                            () => Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor:
                                                      Colors.blue[100],
                                                  backgroundImage: (controller
                                                          .selectedPhoto
                                                          .value
                                                          .path
                                                          .isNotEmpty)
                                                      ? FileImage(File(
                                                          controller
                                                              .selectedPhoto
                                                              .value
                                                              .path))
                                                      : (controller.userPhoto
                                                              .value.isNotEmpty)
                                                          ? MemoryImage(
                                                              base64Decode(
                                                                  controller
                                                                      .userPhoto
                                                                      .value))
                                                          : null,
                                                ),
                                                if (controller.selectedPhoto
                                                        .value.path.isEmpty &&
                                                    controller.userPhoto.value
                                                        .isEmpty)
                                                  Positioned.fill(
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 50,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.blue[500],
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller:
                                          controller.usernameController.value,
                                      decoration: InputDecoration(
                                        labelText: "Username",
                                        hintText: "Masukkan nama pengguna",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextField(
                                      controller:
                                          controller.phoneController.value,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: "Nomer Telepon",
                                        hintText: "Masukkan nomer telephone",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Jenis Kelamin',
                                      ),
                                    ),
                                    Obx(() => Column(
                                          children: [
                                            RadioListTile<String>(
                                              title: const Text("Laki-laki"),
                                              value: "Laki-laki",
                                              groupValue: controller
                                                  .selectedGender.value,
                                              onChanged: (value) {
                                                controller.selectedGender
                                                    .value = value!;
                                              },
                                            ),
                                            RadioListTile<String>(
                                              title: const Text("Perempuan"),
                                              value: "Perempuan",
                                              groupValue: controller
                                                  .selectedGender.value,
                                              onChanged: (value) {
                                                controller.selectedGender
                                                    .value = value!;
                                              },
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 15),
                                    TextField(
                                      controller:
                                          controller.usiaController.value,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: "Usia",
                                        hintText: "Masukkan usia",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    controller.selectedPhoto.value = XFile('');
                                    controller.usernameController.value.text =
                                        controller.userName.value;
                                    controller.phoneController.value.text =
                                        controller.userPhone.value;
                                    Get.back();
                                  },
                                  child: const Text("Batal",
                                      style: TextStyle(color: Colors.black54)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    String updatedUsername = controller
                                        .usernameController.value.text
                                        .trim();
                                    String updatedPhone = controller
                                        .phoneController.value.text
                                        .trim();

                                    if (updatedUsername.isEmpty ||
                                        updatedPhone.isEmpty) {
                                      Get.snackbar(
                                          "Error", "Semua kolom harus diisi!",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }

                                    if (controller
                                        .selectedPhoto.value.path.isNotEmpty) {
                                      await controller.updateProfileWithPhoto();
                                    } else {
                                      await controller.updateProfile();
                                    }
                                    Get.back();
                                  },
                                  child: const Text("Simpan",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: const Text(
                                "Konfirmasi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                "Apakah Anda yakin ingin keluar?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text(
                                    "Batal",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.logout();
                                  },
                                  child: const Text(
                                    "Keluar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: TapToExpand(
                    backgroundcolor: Colors.blue[100],
                    curve: Curves.easeInOut,
                    titlePadding: EdgeInsets.fromLTRB(16, 0, 10, 20),
                    title: Text(
                      'Obat yang Harus diminum',
                      style: TextStyle(
                        fontFamily: 'Caudex',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    iconColor: Colors.black,
                    content: controller.obx((state) => SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: state!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                      "${state[index].frequency.toString()} kali sehari")
                                ],
                              );
                            },
                          ),
                        )),
                    borderRadius: BorderRadius.circular(10),
                    outerClosedPadding: 0,
                    outerOpenedPadding: 0,
                    openedHeight: 80,
                    closedHeight: 80,
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () => showCustomBottomSheet(context),
                    child: Container(
                      height: 50.h,
                      width: 150.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[500]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('About Us'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.info_outline)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5.h,
            width: 70.h,
            color: Colors.grey,
          ),
          RichText(
              text: TextSpan(
                  text: 'Med',
                  style: const TextStyle(
                      fontFamily: 'Caudex',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent),
                  children: [
                TextSpan(
                  text: 'Time',
                  style: const TextStyle(
                      fontFamily: 'Caudex',
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.green),
                )
              ])),
          const SizedBox(height: 16),
          const Text('============================================='),
          Text(
            'Created by \nFarhan Sulis Febriyan. \nINFORMATICS \n22SA11A107',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black),
          ),
          const Text(
              '-------------------------------------------------------------------------------------'),
          const SizedBox(
            height: 8,
          ),
          const Text('Medication Time'),
          const Text('\u00A9 2025'),
          const Text('Version 1.0.0'),
          const Text('============================================='),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
