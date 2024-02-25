import 'package:PassMan/constants/globals.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<dynamic> passwords = [];
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadPasswords();
  }

  Future<void> loadPasswords() async {
    passwords = await passmanDb.query(passwordsTable);
    print(passwords);
    loading.value = false;
  }
}
