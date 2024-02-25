import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/views/authenticate/authenticate_controller.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticateView extends GetView<AuthenticateController> {
  const AuthenticateView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          Text(
            "Hello there,\nlet's manage some passwords",
            style: TextStyle(color: AppColors.fifth, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Obx(
            () => controller.checkingDb.value
                ? Text(
                    "initializing...",
                    style: TextStyle(color: AppColors.fifth),
                  )
                : TextFormField(
                    onFieldSubmitted: controller.checkPassphrase,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    obscureText: true,
                    style: TextStyle(color: AppColors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      label: Center(
                          child: Text(controller.isPassphraseSet
                              ? "passphrase"
                              : "set up your passphrase")),
                      labelStyle: TextStyle(color: AppColors.white),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      floatingLabelStyle: TextStyle(color: AppColors.white),
                      filled: true,
                      fillColor: AppColors.second,
                      border: InputBorder.none,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
