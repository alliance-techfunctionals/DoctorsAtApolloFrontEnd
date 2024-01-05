import "package:apollo_application/routes/routes.dart";
import "package:apollo_application/services/api_services.dart";
import "package:apollo_application/shared_preference/login_shared_preference.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:svg_flutter/svg.dart";

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _uhID = TextEditingController();
  final TextEditingController _bedID = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  int _selectedRadio = 1;

  @override
  Widget build(BuildContext context) {
    // final patientRegistrationDetalils = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F5),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            leading: Container(
              transform: Matrix4.translationValues(-4, -4, 0),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.patientsList);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF07AEB8),
                    ),
                  ),
                ),
              ),
            ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 19),
                  SizedBox(
                    width: 35,
                    height: 40,
                    child: SvgPicture.asset("assets/images/registration.svg"),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Patient Registration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 500,
            decoration: const BoxDecoration(color: Color(0xFFF1F5F5)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter Patient Name',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF07AEB8))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Patient Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Patient Category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedRadio = 1;
                                    _categoryController.text = 'IPD';
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: _selectedRadio == 1
                                          ? const Color(0xFF07AEB8)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'IPD',
                                      style: TextStyle(
                                        color: _selectedRadio == 1
                                            ? Colors.white
                                            : Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedRadio = 2;
                                    _categoryController.text = 'OPD';
                                  });
                                  _uhID.clear();
                                  _bedID.clear();
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: _selectedRadio == 2
                                          ? const Color(0xFF07AEB8)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'OPD',
                                      style: TextStyle(
                                          color: _selectedRadio == 2
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _patientIdController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF07AEB8))),
                        labelText: 'Patient ID',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter your Patient ID',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Patient ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _uhID,
                            // enabled: _selectedRadio == 2 ? false : true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF07AEB8))),
                              labelText: 'UHID',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              hintText: 'UHID',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _bedID,
                            enabled: _selectedRadio == 2 ? false : true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _selectedRadio == 1
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.2),
                              contentPadding: const EdgeInsets.all(16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF07AEB8))),
                              labelText: 'Bed ID',
                              labelStyle: TextStyle(
                                color: _selectedRadio == 1
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              hintText: 'Bed ID',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await SharedPreferencesUtil.logout();
                          Navigator.pushNamed(context, MyRoutes.loginRoute);
                        },
                        child: Text('data')),
                    const Spacer(),
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
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          //   Navigator.pushReplacementNamed(
                          //       context, MyRoutes.patientsList);
                          //   patientRegistrationDetalils.registerUser(
                          //     _nameController.text,
                          //     _bedID.text,
                          //     _categoryController.text,
                          //     _uhID.text,
                          //     _patientIdController.text,
                          //   );
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'SAVE DETAILS',
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
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: const Color(0xFF858585),
      //   selectedFontSize: 12.0,
      //   unselectedFontSize: 10.0,
      //   currentIndex: _selectedIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
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
