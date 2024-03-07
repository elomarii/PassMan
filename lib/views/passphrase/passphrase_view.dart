import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/views/passphrase/passphrase_controller.dart';
import 'package:PassMan/widgets/app_bar.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:PassMan/widgets/button.dart';
import 'package:PassMan/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassphraseView extends GetView<PassphraseController> {
  const PassphraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.second,
      appBar: const PassBar(title: "config"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          AppTextField(
            controller: controller.old,
            label: "current passphrase",
            fillColor: AppColors.first,
          ),
          const SizedBox(height: 10),
          AppTextField(
            fillColor: AppColors.first,
            controller: controller.neu,
            label: "new passphrase",
          ),
          const SizedBox(height: 20),
          Button(title: "save", onPressed: controller.changePassphrase),
          const SizedBox(height: 20),
          Divider(color: AppColors.fourth),
          const SizedBox(height: 20),
          Button(
              title: ">> export passwords >>",
              expanded: true,
              onPressed: controller.exportData),
        ],
      ),
    );
  }
}
