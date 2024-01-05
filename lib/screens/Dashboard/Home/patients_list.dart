import "package:apollo_application/constants/constants.dart";
import "package:apollo_application/routes/routes.dart";
import "package:apollo_application/services/api_services.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
// import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:svg_flutter/svg.dart";
import 'package:dotted_line/dotted_line.dart';

import "controller.dart";

class PatientsList extends StatefulWidget {
  const PatientsList({
    super.key,
  });

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  final DashBoardController controller = Get.put(DashBoardController());
  @override
  void initState() {
    controller.getPatientsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xFFF1F5F5),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.98, 0.18),
                end: Alignment(-0.98, -0.18),
                colors: [Color(0xFF07AEB8), Color(0xFF17E3CC)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const Text(
                    'Brajesh Verma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search by Patient ID / Name / UHID",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 3, 208, 244),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        return RefreshIndicator(
          color: skycolor,
          onRefresh: () async {
            return await controller.getPatientsData();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Patients List',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.patientData.length,
                    itemBuilder: (context, index) {
                      var data = controller.patientData[index];

                      return Card(
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.patientName}',
                                    style: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    // '${widget.patientData[index]['Category']}',
                                    '${data.category}',
                                    style: TextStyle(
                                      color: data.category == 'IPD'
                                          ? const Color(0xFF07AEB8)
                                          : const Color(0xFF17E3CC),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PatientColumnWidget(
                                    label: 'UHID',
                                    value: data.uhid.toString(),
                                  ),
                                  const Column(
                                    children: [
                                      DottedLine(
                                        direction: Axis.vertical,
                                        lineLength: 44,
                                        dashLength: 2,
                                        dashGapLength: 2,
                                        dashColor: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  PatientColumnWidget(
                                    label: 'BED ID',
                                    value: data.bedId.toString(),
                                  ),
                                  const Column(
                                    children: [
                                      DottedLine(
                                        direction: Axis.vertical,
                                        lineLength: 44,
                                        dashLength: 2,
                                        dashGapLength: 2,
                                        dashColor: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  PatientColumnWidget(
                                    label: 'PATIENT ID',
                                    value: data.ipId.toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF1F5F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                  "assets/icons/visit.png"),
                                              Text(
                                                data.visitCount! > 1
                                                    ? 'VISIT(S)'
                                                    : 'VISIT',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                ' ${data.visitCount}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF1F5F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                  "assets/icons/procedure.png"),
                                              Text(
                                                data.procedureCount! > 1
                                                    ? 'PROCEDURE(S)'
                                                    : 'PROCEDURE',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                ' ${data.procedureCount}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF07AEB8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushReplacementNamed(
                      //     context, MyRoutes.registerRoute);
                      controller.getPatientsData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'ADD PATIENT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      // bottomNavigationBar:
      //  BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: const Color(0xFF858585),
      //   selectedFontSize: 12.0,
      //   unselectedFontSize: 10.0,
      //   onTap: (index) {},
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Column(
      //         children: [
      //           Icon(Icons.home),
      //         ],
      //       ),
      //       label: 'HOME',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Column(
      //         children: [
      //           Icon(Icons.person),
      //         ],
      //       ),
      //       label: 'ADD PATIENT',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Column(
      //         children: [
      //           Icon(Icons.report_problem_outlined),
      //         ],
      //       ),
      //       label: 'REPORT',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Column(
      //         children: [
      //           Icon(Icons.menu),
      //         ],
      //       ),
      //       label: 'MORE',
      //     ),
      //   ],
      // ),
    );
  }
}

class PatientColumnWidget extends StatelessWidget {
  final String label;
  final String value;

  const PatientColumnWidget(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
