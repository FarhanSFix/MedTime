import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/medicine.dart';
import '../../../data/notification.dart' as notif;
import '../controllers/detail_medicine_controller.dart';

class DetailMedicineView extends GetView<DetailMedicineController> {
  const DetailMedicineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Jadwal'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              FutureBuilder<Medicine>(
                future: controller.getMedicineData(Get.arguments),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListTile(
                      title: Text(
                        snapshot.data!.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                          "${snapshot.data!.frequency.toString()} kali sehari"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder<List<notif.Notification>>(
                future: controller.getNotificationData(Get.arguments),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].time),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Saya tidak perlu minum obat ini lagi'),
                    onPressed: () {
                      controller.deleteMedicine(Get.arguments);
                    },
                  ))
            ],
          ),
        ));
  }
}
