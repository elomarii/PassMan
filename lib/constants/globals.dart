import 'package:cryptography/cryptography.dart';
import 'package:sqflite/sqlite_api.dart';

// Database variables
late Database passmanDb;
const String passmanPath = "passman.db";
const String passwordsTable = "passwords";
const String passphrasesTable = "passphrases";

String? passphrase;
String? passphraseHash;

// Cryptography related declarations
AesGcm algorithm = AesGcm.with256bits();
const String hashSalt = "a1b2c3d4";
