import 'dart:convert';

import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/constants/globals.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';
import 'package:sqflite/sqflite.dart';

class AuthenticateController extends GetxController {
  bool isPassphraseSet = false;
  RxBool checkingDb = true.obs;

  @override
  void onInit() async {
    super.onInit();
    String path = await getDatabasesPath();
    passmanDb = await initPassmanDb(path);

    // for dev, clean the database when reload
    // passmanDb.delete(passphrasesTable);
    // passmanDb.delete(passwordsTable);

    List<Map> passphrases =
        await passmanDb.rawQuery('SELECT * FROM $passphrasesTable');

    if (passphrases.isNotEmpty) {
      isPassphraseSet = true;
      passphraseHash = passphrases[0]["hash"];
      printInfo(info: "hash found: $passphraseHash");
    }
    checkingDb.value = false;
  }

  Future<Database> initPassmanDb(String databasesPath) async {
    return await openDatabase(
      databasesPath + passmanPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $passphrasesTable (id INTEGER PRIMARY KEY, hash TEXT NOT NULL)");
        await db.execute(
            "CREATE TABLE $passwordsTable (id INTEGER PRIMARY KEY, platform TEXT NOT NULL, value TEXT NOT NULL)");
      },
    );
  }

  Future<void> checkPassphrase(String value) async {
    String hashed = await computeHash(value);
    if (isPassphraseSet) {
      if (hashed == passphraseHash) {
        printInfo(info: "Hashes match");
        passphrase = HEX.encode(utf8.encode(value));
        Get.offAllNamed(AppRoutes.home);
      } else {
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
      }
    } else {
      printInfo(info: "New passphrase setup");
      passphrase = HEX.encode(utf8.encode(value));
      await passmanDb.rawInsert(
          'INSERT INTO $passphrasesTable(id, hash) VALUES(1, "$hashed")');
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
