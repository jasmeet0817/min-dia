import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_dia/routes/app_routes.dart';
import 'package:min_dia/routes/routes_name.dart';

import 'controllers/audio_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AudioController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Min-Dia Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.homeView,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
