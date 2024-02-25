import 'package:sqflite/sqlite_api.dart';

// Database variables
late Database passmanDb;
const String passmanPath = "passman.db";
const String passwordsTable = "passwords";
const String passphrasesTable = "passphrases";

String? passphrase;
String? passphraseHash;

// Cryptography related declarations
const List<int> auxilaryNonce = [0, 1, 2, 3, 4];
