import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/views/password/password_controller.dart';
import 'package:PassMan/widgets/app_bar.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:PassMan/widgets/button.dart';
import 'package:PassMan/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      appBar: const PassBar(),
      body: Form(
        key: controller.form,
        child: Column(
          children: [
            const SizedBox(height: 20),
            AppTextField(
              controller: controller.platform,
              label: "platform",
              fillColor: AppColors.first,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: controller.value,
              label: "value",
              fillColor: AppColors.first,
            ),
            const SizedBox(height: 25),
            Button(
              title: "save",
              onPressed: controller.savePassword,
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: controller.passId != null,
              child: Button(
                title: "delete",
                onPressed: controller.deletePassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
