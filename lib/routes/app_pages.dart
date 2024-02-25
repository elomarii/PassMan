import 'package:PassMan/routes/app_bindings.dart';
import 'package:PassMan/routes/app_routes.dart';
import 'package:PassMan/views/authenticate/authenticate_view.dart';
import 'package:PassMan/views/home/home_view.dart';
import 'package:PassMan/views/password/password_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.authenticate,
      page: () => const AuthenticateView(),
      binding: AuthenticateBinding(),
    ),
    GetPage(
      name: AppRoutes.password,
      page: () => const PasswordView(),
      binding: PasswordBinding(),
    ),
  ];
}
