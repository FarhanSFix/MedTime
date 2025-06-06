import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Jadwal'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Center(
                child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Tambah Jadwal Minum Obat',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w500,
                        fontSize: 27),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Nama Obat',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kolom ini tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: TextFormField(
                    controller: controller.frequencyController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Frekuensi (/hari)',
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.isNotEmpty && int.tryParse(value) != null) {
                        int newFreq = int.parse(value);
                        controller.updateTimeControllers(newFreq);
                        controller.frequency.value = newFreq;
                      } else {
                        controller.updateTimeControllers(0);
                        controller.frequency.value = 0;
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kolom ini tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.frequency.value,
                        itemBuilder: (context, index) {
                          if (index >= controller.timeController.length) {
                            controller.timeController
                                .add(TextEditingController());
                          }
                          return Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              controller: controller.timeController[index],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Set Waktu',
                              ),
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                displayTimePicker(
                                    context, controller.timeController[index]);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kolom ini tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      )),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Tambah'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.add(controller.nameController.text,
                              int.parse(controller.frequencyController.text));
                        }
                      },
                    )),
              ],
            )),
          ),
        ));
  }

  Future displayTimePicker(
      BuildContext context, TextEditingController textfieldController) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      textfieldController.text = "${time.hour}:${time.minute}";
    }
  }
}
