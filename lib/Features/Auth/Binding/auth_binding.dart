import 'package:get/get.dart';
import 'package:patungan/Features/Auth/Controller/auth_controller.dart';
import 'package:patungan/Features/Auth/Service/auth_service.dart';
import 'package:patungan/Features/Auth/Service/auth_storage.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());

    Get.lazyPut<AuthStorage>(() => AuthStorage());

    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
        authStorage: Get.find<AuthStorage>(),
      ),
    );
  }
}
