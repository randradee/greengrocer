import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/routes/app_routes.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';

void main() {
  Get.put<AuthController>(AuthController());
  runApp(const Greengrocer());
}

class Greengrocer extends StatelessWidget {
  const Greengrocer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      initialRoute: PagesRoutes.splashRoute,
    );
  }
}
