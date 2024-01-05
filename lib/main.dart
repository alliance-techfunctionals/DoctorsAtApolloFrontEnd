import 'package:apollo_application/routes/routes.dart';
import 'package:apollo_application/screens/Auth/login.dart';
import 'package:apollo_application/screens/Dashboard/AddPatient/patient_registration.dart';
import 'package:apollo_application/screens/Dashboard/Home/home.dart';
import 'package:apollo_application/screens/Dashboard/Home/patients_list.dart';
import 'package:apollo_application/shared_preference/login_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Apollo",
      debugShowCheckedModeBanner: false,
      // home: ,
      routes: {
        MyRoutes.splashScrean: (context) => Spl(),
        MyRoutes.home: (p0) => Home(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.registerRoute: (context) => const RegisterPage(),
        MyRoutes.patientsList: (context) => const PatientsList(),
      },
    );
  }
}

class Spl extends StatefulWidget {
  const Spl({super.key});

  @override
  State<Spl> createState() => _SplState();
}

class _SplState extends State<Spl> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    v();
  }

  Future v() async {
    await Future.delayed(Duration(seconds: 4), () async {
      SharedPreferencesUtil.getLogin().then((value) {
        if (value == true) {
          Navigator.pushNamed(context, MyRoutes.home);
        } else {
          Navigator.pushNamed(context, MyRoutes.loginRoute);
        }
        ;
      });

      // return Navigator.pushNamed(context, MyRoutes.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: skycolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome to Apollo',
                // '',
                style: GlobalFonts.ts22px700w.copyWith(color: Colors.white),
              ),
            ),
            // Image.asset("assets/images/doctor.png")
          ],
        ));
  }
}
