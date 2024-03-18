import 'dart:convert';
import 'dart:io';

import 'package:PassMan/constants/globals.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PassphraseController extends GetxController {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController old = TextEditingController();
  TextEditingController neu = TextEditingController();

  Future<void> changePassphrase() async {
    if (!formkey.currentState!.validate()) return;
    String given = HEX.encode(utf8.encode(old.text));
    if (given != passphrase) {
      showdialog("wrong current passphrase !");
      return;
    }

    passphrase = HEX.encode(utf8.encode(neu.text));
    String hash = await computeHash(neu.text);
    await passmanDb.update(passphrasesTable, {"hash": hash}, where: "id = 1");
    await encryptAll(given);
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

  /// Export all passwords as a file to the app folder in local storage
  /// The created file is named `passwords.pman`
  Future<void> exportData() async {
    bool success = false;
    try {
      if (await Permission.storage.request().isGranted) {
        String path = "${(await getDownloadsDirectory())!.path}/passwords.pman";
        File targetFile = File(path);
        await passmanDb.query(passwordsTable).then((response) async {
          for (int i = 0; i < response.length; i++) {
            targetFile.writeAsStringSync(
              "${response[i]["platform"]}:${response[i]["value"]}:${response[i]["salt"]}\n",
              mode: i == 0 ? FileMode.write : FileMode.append,
            );
          }
        });
        success = true;
      } else {
        printError(info: "couldn't get permissions");
      }
    } on Exception catch (e) {
      e.printError();
    }
    showSnackbar(
        success ? "success > exported to app folder" : "operation failed");
  }
}
