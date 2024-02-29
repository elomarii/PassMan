import 'package:PassMan/views/passphrase/passphrase_controller.dart';
import 'package:PassMan/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassphraseView extends GetView<PassphraseController> {
  const PassphraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const Placeholder());
  }
}
