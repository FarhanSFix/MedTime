import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_remember/app/modules/login/controllers/login_controller.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    Size screenSize = const Size(414, 895);
    return ScreenUtilInit(
      designSize: screenSize,
      builder: (_, child) => StreamBuilder<User?>(
          stream: authC.streamAuthStatus,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot);
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Medicin Remember",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                theme: ThemeData(
                  primarySwatch: Colors.indigo,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
