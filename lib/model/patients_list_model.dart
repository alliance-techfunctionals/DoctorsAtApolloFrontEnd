class PatientModel {
  int? id;
  String? patientName;
  String? category;
  String? uhid;
  String? ipId;
  String? bedId;
  int? visitCount;
  int? procedureCount;

  PatientModel({
    this.id,
    this.patientName,
    this.category,
    this.uhid,
    this.ipId,
    this.bedId,
    this.visitCount,
    this.procedureCount,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['Id'] != null ? int.tryParse(json['Id'].toString()) : 0,
      patientName: json['PatientName'] ?? '',
      category: json['Category'] ?? '',
      uhid: json['UHID'] ?? '',
      ipId: json['IPId'] ?? '',
      bedId: json['BedId'] ?? '',
      visitCount: json['VisitCount'] != null
          ? int.tryParse(json['VisitCount'].toString())
          : 0,
      procedureCount: json['ProcedureCount'] != null
          ? int.tryParse(json['ProcedureCount'].toString())
          : 0,
    );
  }
}
// class PatientModel {
//   final String patientName;
//   final String category;
//   final String uhid;
//   final String ipId;
//   final String bedId;
//   final int visitCount;
//   final int procedureCount;

//   PatientModel({
//     required this.patientName,
//     required this.category,
//     required this.uhid,
//     required this.ipId,
//     required this.bedId,
//     required this.visitCount,
//     required this.procedureCount,
//   });

//   factory PatientModel.fromJson(Map<String, dynamic> json) {
//     return PatientModel(
//       patientName: json['PatientName'] ?? '',
//       category: json['Category'] ?? '',
//       uhid: json['UHID'] ?? '',
//       ipId: json['IPId'] ?? '',
//       bedId: json['BedId'] ?? '',
//       visitCount: json['VisitCount'] ?? 0,
//       procedureCount: json['ProcedureCount'] ?? 0,
//     );
//   }
// }

// Usage example:

