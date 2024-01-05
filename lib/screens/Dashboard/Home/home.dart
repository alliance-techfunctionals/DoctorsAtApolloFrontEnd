import 'package:apollo_application/screens/Dashboard/Home/controller.dart';
import 'package:apollo_application/screens/Dashboard/Home/patients_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AddPatient/patient_registration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DashBoardController controller = Get.put(DashBoardController());
  @override
  List<Widget> screens = [
    const Center(child: PatientsList()),
    const RegisterPage(),
    const Center(
      child: Text('3'),
    ),
    const Center(
      child: Text('4'),
    )
  ];

  int _indextOfScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_indextOfScreen),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF858585),
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        items: const [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(Icons.home),
              ],
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(Icons.person),
              ],
            ),
            label: 'ADD PATIENT',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(Icons.report_problem_outlined),
              ],
            ),
            label: 'REPORT',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(Icons.menu),
              ],
            ),
            label: 'MORE',
          ),
        ],
        currentIndex: _indextOfScreen,
        onTap: (value) {
          setState(() {
            _indextOfScreen = value;
          });
        },
      ),
      // BottomNavigationBar(
      //   items: [
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       //  Column(
      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       //   children: [Icon(Icons.home), Text('HOME')],
      //       // ),
      //       label: 'HOME',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(ApolloAssets.patient),
      //       label: 'ADD PATIENT',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         ApolloAssets.reportIcon,
      //         height: 30,
      //       ),
      //       label: 'REPORT',
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.menu),
      //       label: 'Menu',
      //     ),
      //   ],
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: skyColor,
      //   unselectedItemColor: Colors.black,
      //   currentIndex: _indextOfScreen,
      //   onTap: (value) {
      //     setState(() {
      //       _indextOfScreen = value;
      //     });
      //   },
      // ),
    );
  }
}
