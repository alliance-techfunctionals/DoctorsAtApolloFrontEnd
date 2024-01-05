import 'package:apollo_application/services/controller/base_controler.dart';

import '../../services/api_services.dart';

class AuthController extends BaseController {
  final ApiServices _api = ApiServices();

  Future loginUser(String mobileNumber, String password) async {
    await _api.loginUser(mobileNumber, password);
  }
}
