import 'package:apollo_application/services/api_services.dart';
import 'package:apollo_application/services/controller/base_controler.dart';
import 'package:get/get.dart';

import '../../../model/patients_list_model.dart';

class DashBoardController extends BaseController {
  final ApiServices _api = ApiServices();
  // RxList<PatientModel> patientData = RxList();
  RxList<PatientModel> patientData = <PatientModel>[].obs;
  Future getPatientsData() async {
    patientData.value = await _api.fetchPatientList();
    print(patientData.length);
  }
}
