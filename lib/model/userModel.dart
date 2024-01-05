class RegisterModel {
  final int doctorId;
  final String patientName;
  final String bedId;
  final String category;
  final String uhId;
  final String ipId;

  RegisterModel({
    required this.doctorId,
    required this.patientName,
    required this.bedId,
    required this.category,
    required this.uhId,
    required this.ipId,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'patientName': patientName,
      'bedId': bedId,
      'category': category,
      'uhId': uhId,
      'ipId': ipId,
    };
  }
}


// RegisterModel registerData = RegisterModel(
//   doctorId: 0,
//   patientName: "John Doe",
//   bedId: "123",
//   category: "OPD",
//   uhId: "456",
//   ipId: "789",
// );

// String? registrationResult = await registerUser(registerData);
