import 'package:apollo_application/services/Bindings/base_binding.dart';

import 'package:get/get.dart';

import '../auth_conrtoller.dart';

class AuthBinding extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
