// import 'package:apollo_application/shared_preference/login_shared_preference.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// Future<void> decodeToken() async {
//   String? token = await SharedPreferencesUtil.getToken();

//   if (token != null) {
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//     // String DoctorId = decodedToken['doctorId'];
//     // String DoctorName = decodedToken['doctorName'];
//     print('Decoded Token -$decodedToken');
//   } else {
//     print('Token not found');
//   }
// }

import 'package:apollo_application/shared_preference/login_shared_preference.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<Map<String, dynamic>?> getDecodedToken() async {
  String? token = await SharedPreferencesUtil.getToken();

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print('Decoded Token -$decodedToken');
    return decodedToken;
  }

  return null;
}
