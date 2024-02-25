import 'package:PassMan/views/authenticate/authenticate_controller.dart';
import 'package:PassMan/views/home/home_controller.dart';
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
