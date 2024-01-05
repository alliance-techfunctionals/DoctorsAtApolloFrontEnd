import 'dart:convert';
import 'package:apollo_application/model/patients_list_model.dart';
import 'package:apollo_application/model/userModel.dart';
import 'package:apollo_application/shared_preference/login_shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
// import 'login_shared_preference.dart'; // Import the SharedPreferences utility class

class ApiServices {
  Future<String?> loginUser(String mobileNumber, String password) async {
    const String apiUrl = 'http://3.25.222.181:5081/api/authorization/LogIn';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'mobileNumber': mobileNumber,
          'password': password,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );

      // print('response of token ${response.body}');
      print("-----------: ${response.statusCode}");

      if (response.statusCode == 200) {
        String token = response.body;

        String modifiedToken = token.replaceAll('"', '').replaceAll('\\', '');

        await SharedPreferencesUtil.saveToken(modifiedToken);
        SharedPreferencesUtil.setLogin(true);
        // await SharedPreferencesUtil.isLogined(true);

        return token;
      } else {
        print("Login failed: ${response.statusCode}");
        // SharedPreferencesUtil.isLogined(false);
        return null;
      }
    } catch (error) {
      print("Error during login API call: $error");
      return null;
    }
  }

  // REGISTER

  Future<String?> registerUser(
    String patientName,
    String bedId,
    String category,
    String uhId,
    String ipId,
  ) async {
    const String apiUrl = 'http://3.25.222.181:5081/api/Patient/Insert';
    var tkn = await SharedPreferencesUtil.getToken();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'doctorId': 0,
          'patientName': patientName,
          'bedId': bedId,
          'category': category,
          'uhId': uhId,
          'ipId': ipId,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $tkn",
        },
      );

      print('response---register----${response.body}');

      if (response.statusCode == 200) {
        String token = response.body;

        return token;
      } else {
        print("Registration failed: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error during registration API call: $error");
      return null;
    }
  }

// GET-PATEINTS-LIST

  Future fetchPatientList() async {
    var tkn = await SharedPreferencesUtil.getToken();
    const String apiUrl =
        'http://3.25.222.181:5081/api/Patient/PatientList?doctorId=4';

    // try {
    final response = await Dio().get(apiUrl,
        options: Options(headers: {
          "Authorization": "Bearer $tkn",
        }));
    //     await http.get(Uri.parse(apiUrl), headers: {
    //   "Authorization": "Bearer $tkn",
    // });

    print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      // List<dynamic> result = jsonDecode(jsonDecode(response.body)["result"]);
      // debugPrint('patientList------${result}');
      // List<Map<String, dynamic>> patientList = List.from(result.map((item) {
      //   return jsonDecode(item);
      // }));
    } else {
      print("Failed to fetch patient list: ${response.statusCode}");
      // return null;
    }
    // List<PatientModel> patientData = [];
    RxList<PatientModel> patientData = <PatientModel>[].obs;
    for (var e in jsonDecode(response.data['result'])) {
      patientData.add(PatientModel.fromJson(e));
    }

    debugPrint('${patientData}');
    return patientData;
    // } catch (error) {
    //   print("Error during API call: $error");
    //   // return null;
    // }
  }

  // Future<String?> registerUser(RegisterModel registerData) async {
  //   const String apiUrl = 'http://3.25.222.181:5081/api/Patient/Insert';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: jsonEncode(registerData.toJson()),
  //       headers: {
  //         "Accept": "application/json",
  //         "content-type": "application/json"
  //       },
  //     );

  //     print(response);

  //     if (response.statusCode == 200) {
  //       String token = response.body;
  //       return token;
  //     } else {
  //       print("Registration failed: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (error) {
  //     print("Error during registration API call: $error");
  //     return null;
  //   }
  // }
}

// final userProvider = Provider<ApiServices>((ref) => ApiServices());







// "\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ijk4MTAwMzMzOTQiLCJleHAiOjE3OTA3NDU2OTMsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA4MSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA4MSJ9.q7oi0gFaBNWuoan9jw_-2cr0Sm8pbQW52HqpXuSeOtQ\""