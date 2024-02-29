import 'dart:convert';
import 'dart:typed_data';

import 'package:PassMan/constants/globals.dart';
import 'package:cryptography/cryptography.dart';
import 'package:hex/hex.dart';
import 'package:sqflite/utils/utils.dart';

Future<String> computeHash(String value) async {
  final algorithm = Argon2id(
    memory: 5 * 1000,
    parallelism: 1,
    iterations: 2,
    hashLength: 128,
  );

  final secretKey = await algorithm.deriveKeyFromPassword(
    password: value,
    nonce: auxilaryNonce,
  );

  final hashBytes = await secretKey.extractBytes();
  return hex(hashBytes);
}

Future<String> encrypt(String value, {String? secret}) async {
  secret = secret ?? passphrase!;
  SecretBox encryption = await algorithm.encrypt(
    utf8.encode(value),
    secretKey:
        SecretKey(HEX.decode(secret) + List.filled(32 - secret.length ~/ 2, 0)),
    nonce: auxilaryNonce,
  );
  return HEX.encode(encryption.concatenation());
}

Future<String> decrypt(String value, {String? secret}) async {
  secret = secret ?? passphrase!;
  Uint8List encrypted = Uint8List.fromList(HEX.decode(value));
  SecretBox box = SecretBox.fromConcatenation(encrypted,
      macLength: algorithm.macAlgorithm.macLength,
      nonceLength: auxilaryNonce.length);
  List<int> decrypted = await algorithm.decrypt(
    box,
    secretKey:
        SecretKey(HEX.decode(secret) + List.filled(32 - secret.length ~/ 2, 0)),
  );
  return utf8.decode(decrypted);
}
