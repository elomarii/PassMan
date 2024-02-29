import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/views/home/home_controller.dart';
import 'package:PassMan/widgets/app_bar.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:cryptography/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      fab: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.password, arguments: null),
        backgroundColor: AppColors.first,
        focusColor: AppColors.third,
        splashColor: AppColors.fourth,
        child: const Text("add"),
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

class PasswordCard extends StatefulWidget {
  const PasswordCard(
      {super.key,
      required this.platform,
      required this.value,
      required this.id});

  final int id;
  final String platform;
  final String value;

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  String scrambled = randomBytesAsHexString(10);
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.first),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed(
                AppRoutes.password,
                arguments: [widget.id, widget.platform, widget.value],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.platform,
                    style: TextStyle(
                        color: AppColors.fifth,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isShown ? widget.value : scrambled,
                    style: TextStyle(color: AppColors.white),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              isShown = !isShown;
            }),
            child: Icon(
              isShown ? Icons.lock_open : Icons.lock,
              color: AppColors.fourth,
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.value));
              Get.showSnackbar(GetSnackBar(
                message: "${widget.platform}'s password was copied!",
                duration: const Duration(seconds: 2),
              ));
            },
            child: Icon(
              Icons.copy,
              color: AppColors.fourth,
            ),
          ),
        ],
      ),
    );
  }
}
