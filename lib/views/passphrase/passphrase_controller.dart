import 'dart:convert';

import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/constants/globals.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';

class PassphraseController extends GetxController {
  TextEditingController old = TextEditingController();
  TextEditingController neu = TextEditingController();

  Future<void> changePassphrase() async {
    String current = HEX.encode(utf8.encode(old.text));
    if (current != passphrase) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog.adaptive(
          content: Text(
            "wrong passphrase!",
            style: TextStyle(color: AppColors.fifth),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.second,
        ),
      );
      return;
    }

    passphrase = HEX.encode(utf8.encode(neu.text));
    String hash = await computeHash(passphrase!);
    await passmanDb.update(passphrasesTable, {"hash": hash}, where: "id = 1");
    await encryptAll(current);
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> encryptAll(String old) async {
    await passmanDb.query(passwordsTable).then((response) async {
      for (int i = 0; i < response.length; i++) {
        String decryption = await decrypt(
          response[i]["value"] as String,
          response[i]["salt"] as String,
          secret: old,
        );
        String encryption =
            await encrypt(decryption, response[i]["salt"] as String);
        await passmanDb.update(
          passwordsTable,
          {"value": encryption},
          where: "id = ${response[i]["id"]}",
        );
      }
    });
  }
}
