import 'package:PassMan/constants/globals.dart';
import 'package:cryptography/cryptography.dart';
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
