import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/views/home/home_controller.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.first,
        elevation: 2,
        title: Text(
          "PassMan",
          style: TextStyle(
            color: AppColors.fifth,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "welcome back",
            style: TextStyle(color: AppColors.white),
          )
        ],
      ),
    );
  }
}
