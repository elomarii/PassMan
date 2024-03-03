import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/views/home/home_controller.dart';
import 'package:PassMan/widgets/app_bar.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:PassMan/widgets/password_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      fab: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => Get.toNamed(AppRoutes.password, arguments: null),
            backgroundColor: AppColors.first,
            focusColor: AppColors.third,
            splashColor: AppColors.fourth,
            child: const Text("add"),
          ),
          const SizedBox(width: 4),
          FloatingActionButton(
            heroTag: "__",
            onPressed: () => Get.toNamed(AppRoutes.passphrase),
            backgroundColor: AppColors.first,
            focusColor: AppColors.third,
            splashColor: AppColors.fourth,
            child: Icon(Icons.memory, size: 30, color: AppColors.fifth),
          ),
        ],
      ),
      appBar: const PassBar(),
      body: Obx(
        () => controller.loading.value
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "loading...",
                  style: TextStyle(color: AppColors.fifth),
                  textAlign: TextAlign.center,
                ),
              )
            : controller.passwords.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "no passwords yet",
                      style: TextStyle(color: AppColors.fifth),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (_, index) => index ==
                            controller.passwords.length
                        ? const SizedBox(height: 60)
                        : PasswordCard(
                            id: controller.passwords[index]["id"],
                            platform: controller.passwords[index]["platform"],
                            value: controller.passwords[index]["value"]),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: controller.passwords.length + 1,
                  ),
      ),
    );
  }
}
