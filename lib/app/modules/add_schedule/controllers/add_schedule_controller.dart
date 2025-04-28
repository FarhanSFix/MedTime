import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_remember/app/data/notification.dart' as notif;

import '../../../data/medicine.dart';
import '../../../helper/db_helper.dart';
import '../../../utils/notification_api.dart';
import '../../home/controllers/home_controller.dart';

class AddScheduleController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController frequencyController;
  final RxList<TextEditingController> timeController =
      <TextEditingController>[].obs;

  var db = DbHelper();
  final frequency = 0.obs;

  HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    NotificationApi.init();

    nameController = TextEditingController();
    frequencyController = TextEditingController();
  }

  void updateTimeControllers(int newFrequency) {
    if (newFrequency < timeController.length) {
      for (int i = newFrequency; i < timeController.length; i++) {
        timeController[i].dispose();
      }
      timeController.removeRange(newFrequency, timeController.length);
    }

    while (timeController.length < newFrequency) {
      timeController.add(TextEditingController());
    }
  }

  void add(String name, int frequency) async {
    if (timeController.length < frequency) {
      print(
          "⚠️ Error: timeController tidak cukup, expected: $frequency, found: ${timeController.length}");
      return;
    }

    await db.insertMedicine(Medicine(name: name, frequency: frequency));
    var lastMedicineId = await db.getLastMedicineId();

    for (int i = 0; i < frequency; i++) {
      await db.insertNotification(notif.Notification(
          idMedicine: lastMedicineId, time: timeController[i].text));
    }

    List<notif.Notification> notifications =
        await db.getNotificationsByMedicineId(lastMedicineId);

    for (var element in notifications) {
      if (element.time.contains(":")) {
        List<String> timeParts = element.time.split(":");
        int? hour = int.tryParse(timeParts[0]);
        int? minute = int.tryParse(timeParts[1]);

        if (hour != null && minute != null) {
          NotificationApi.scheduledNotification(
            id: element.id!,
            title: "Waktunya minum obat $name",
            body: "Minum obat agar cepat sembuh :)",
            payload: name,
            scheduledDate: TimeOfDay(hour: hour, minute: minute),
          ).then((value) => print("notif ${element.id} scheduled"));
        } else {
          print(
              "Error: Format waktu tidak valid untuk notifikasi ${element.id}");
        }
      } else {
        print(
            "Error: Format waktu tidak sesuai untuk notifikasi ${element.id}");
      }
    }

    homeController.getAllMedicineData();
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    frequencyController.dispose();
    for (var element in timeController) {
      element.dispose();
    }
    timeController.clear();
  }
}
