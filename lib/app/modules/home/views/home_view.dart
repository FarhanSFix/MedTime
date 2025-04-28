import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:med_remember/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Hallo, ',
                              textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: false,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${controller.userName.value}!",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToFirstAscent: false,
                                  applyHeightToLastDescent: false,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.PROFILE),
                      child: controller.foto.isNotEmpty
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: MemoryImage(
                                base64Decode(controller.foto.value),
                              ),
                            )
                          : CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue[100],
                              child: Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                              ),
                            ),
                    ),
                  ],
                );
              }),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.search,
                decoration: InputDecoration(
                    hintText: 'Cari tahu obat',
                    hintStyle:
                        TextStyle(color: Color(0xFF03071E).withOpacity(0.25)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          String query =
                              Uri.encodeComponent(controller.search.text);
                          String searchUrl =
                              "https://www.google.com/search?q=$query";

                          await launchUrl(
                            Uri.parse(searchUrl),
                          );
                        },
                        icon: const Icon(Icons.search)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              controller.obx(
                (state) => SizedBox(
                  height: 800,
                  child: ListView.builder(
                    itemCount: state!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(Routes.DETAIL_MEDICINE,
                            arguments: state[index].id),
                        child: Card(
                          color: Colors.blue[50],
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state[index].name,
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${state[index].frequency.toString()} kali sehari",
                                      style: TextStyle(
                                          fontFamily: 'Lato', fontSize: 16),
                                    )
                                  ],
                                ),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                onLoading: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400.h,
                    ),
                    const CircularProgressIndicator(),
                    const Text(
                      'Loading...',
                      style: TextStyle(
                        fontFamily: 'Caudex',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
                onEmpty: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                    ),
                    Image.asset(
                      "asset/images/no_data.jpg",
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Text(
                      'Belum ada data',
                      style: TextStyle(
                        fontFamily: 'Caudex',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.toNamed(Routes.ADD_SCHEDULE);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
