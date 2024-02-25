import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/routes/app_pages.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const PassMan());
}

class PassMan extends StatelessWidget {
  const PassMan({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Styling
      title: 'PassMan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kode-mono', primaryColor: AppColors.fifth),
      // Navigation
      defaultTransition: Transition.noTransition,
      initialRoute: AppRoutes.authenticate,
      getPages: AppPages.pages,
    );
  }
}
