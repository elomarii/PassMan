import 'dart:convert';
import 'dart:typed_data';

import 'package:PassMan/constants/colors.dart';
import 'package:PassMan/constants/globals.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';
import 'package:sqflite/utils/utils.dart';

Future<String> computeHash(String value) async {
  final algorithm = Argon2id(
    memory: 5 * 1000,
    parallelism: 1,
    iterations: 2,
    hashLength: 128,
  );

  final hash = await algorithm.deriveKeyFromPassword(
    password: value,
    nonce: HEX.decode(hashSalt),
  );

  final hashBytes = await hash.extractBytes();
  return hex(hashBytes);
}

Future<String> encrypt(String value, String salt, {String? secret}) async {
  secret = secret ?? passphrase!;
  SecretBox encryption = await algorithm.encrypt(
    utf8.encode(value),
    secretKey:
        SecretKey(HEX.decode(secret) + List.filled(32 - secret.length ~/ 2, 0)),
    nonce: HEX.decode(salt),
  );
  return HEX.encode(encryption.concatenation());
}

Future<String> decrypt(String value, String salt, {String? secret}) async {
  secret = secret ?? passphrase!;
  Uint8List encrypted = Uint8List.fromList(HEX.decode(value));
  SecretBox box = SecretBox.fromConcatenation(encrypted,
      macLength: algorithm.macAlgorithm.macLength,
      nonceLength: HEX.decode(salt).length);
  List<int> decrypted = await algorithm.decrypt(
    box,
    secretKey:
        SecretKey(HEX.decode(secret) + List.filled(32 - secret.length ~/ 2, 0)),
  );
  return utf8.decode(decrypted);
}

void showSnackbar(String message) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    duration: const Duration(seconds: 2),
  ));
}

void showdialog(String message) {
  showDialog(
    context: Get.context!,
    builder: (_) => AlertDialog.adaptive(
      content: Text(
        message,
        style: TextStyle(color: AppColors.fifth),
        textAlign: TextAlign.center,
      ),
      shape: const ContinuousRectangleBorder(),
      backgroundColor: AppColors.second,
    ),
  );
}
