import 'package:PassMan/views/authenticate/authenticate_controller.dart';
import 'package:PassMan/views/home/home_controller.dart';
import 'package:PassMan/views/passphrase/passphrase_controller.dart';
import 'package:PassMan/views/password/password_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class AuthenticateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticateController>(() => AuthenticateController());
  }
}

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordController>(() => PasswordController());
  }
}

class PassphraseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassphraseController>(() => PassphraseController());
  }
}
