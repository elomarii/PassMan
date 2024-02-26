import 'package:PassMan/constants/globals.dart';
import 'package:PassMan/utility.dart';
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
    loading.value = true;
    await passmanDb.query(passwordsTable).then((response) async {
      for (int i = 0; i < response.length; i++) {
        String decryption = await decrypt(response[i]["value"] as String);
        passwords.add({
          "id": response[i]["id"],
          "platform": response[i]["platform"],
          "value": decryption
        });
      }
    });
    loading.value = false;
  }
}
