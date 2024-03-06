import 'package:PassMan/constants/globals.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/utility.dart';
import 'package:cryptography/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  int? passId;
  TextEditingController platform = TextEditingController();
  TextEditingController value = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();

  @override
  void onInit() {
    if (Get.arguments != null) {
      passId = Get.arguments[0];
      platform.text = Get.arguments[1];
      value.text = Get.arguments[2];
    }
    super.onInit();
  }

  Future<void> savePassword() async {
    if (!form.currentState!.validate()) return;
    String salt = randomBytesAsHexString(12);
    String encryption = await encrypt(value.text, salt);
    if (passId != null) {
      await passmanDb.update(
        passwordsTable,
        {"platform": platform.text.trim(), "value": encryption, "salt": salt},
        where: "id = ?",
        whereArgs: [passId],
      );
    } else {
      await passmanDb.insert(
        passwordsTable,
        {"platform": platform.text.trim(), "value": encryption, "salt": salt},
      );
    }
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> deletePassword() async {
    await passmanDb.delete(
      passwordsTable,
      where: "id = ?",
      whereArgs: [passId],
    );
    Get.offAllNamed(AppRoutes.home);
  }
}
