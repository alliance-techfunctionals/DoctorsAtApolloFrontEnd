import 'package:apollo_application/constants/constants.dart';
import 'package:apollo_application/decoder/token_decoder.dart';
import 'package:apollo_application/routes/routes.dart';
import 'package:apollo_application/screens/Auth/auth_conrtoller.dart';
import 'package:apollo_application/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController loginDetails = Get.put(AuthController());
  String mobileError = EMPTY_STRING;
  String passwordError = EMPTY_STRING;
  bool clicked = false;
  bool _obscureText = true;
  bool changeButton = false;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordError = EMPTY_STRING;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F5F5),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.98, 0.18),
                    end: Alignment(-0.98, -0.18),
                    colors: [Color(0xFF07AEB8), Color(0xFF17E3CC)],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Align(
                              child: Opacity(
                                opacity: 0.35,
                                child: Container(
                                  width: 0,
                                  height: 300,
                                  margin: const EdgeInsets.only(top: 80),
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF14D9C9),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -50,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 80),
                                    child: Image.asset(
                                        "assets/images/doctor.png")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          color: Colors.transparent,
                          child: Container(
                            height: 450,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F5F5),
                            ),
                            // Login Form
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: SizedBox(
                                          height: 37,
                                          child: Text(
                                            'Doctor’s Login',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF222222),
                                              fontSize: 22,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      SizedBox(
                                        height: 16,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            SvgPicture.asset(
                                                "assets/icons/mobile.svg"),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Mobile Number',
                                              style: TextStyle(
                                                color: Color(0xFF222222),
                                                fontSize: 13,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors

                                      SizedBox(height: 10),
                                      // Mobile number
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Mobile number is required";
                                          } else if (!RegExp(r'^[0-9]{10}$')
                                              .hasMatch(value)) {
                                            return "Please enter a valid 10-digit mobile number";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: mobileController,
                                        maxLength: 10,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                          hintText: "Mobile Number",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(16.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 3, 208, 244)),
                                          ),
                                          errorText:
                                              clicked ? mobileError : null,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          SvgPicture.asset(
                                              "assets/icons/password.svg"),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'PASSWORD',
                                            style: TextStyle(
                                              color: Color(0xFF222222),
                                              fontSize: 13,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Password field
                                      SizedBox(
                                        child: TextFormField(
                                          validator: (password) {
                                            if (password!.isEmpty) {
                                              return "Password is required";
                                            } else if (password.length < 8) {
                                              return "Password should be at least 8 characters";
                                            } else if (password.length > 15) {
                                              return "Password should be at most 15 characters";
                                            } else if (!password
                                                .contains(RegExp(r'[A-Z]'))) {
                                              return "Password should contain at least one uppercase letter";
                                            } else if (!password.contains(RegExp(
                                                r'[!@#$%^&*(),.?":{}|<>]'))) {
                                              return "Password should contain at least one special character";
                                            }
                                            return null;
                                          },
                                          controller: passwordController,
                                          obscureText: _obscureText,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                15),
                                          ],
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(16.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 3, 208, 244)),
                                            ),
                                            errorText:
                                                clicked ? passwordError : null,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 20),
                                      SizedBox(
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () async {
                                              print(mobileError);
                                              print(passwordController);

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await loginDetails.loginUser(
                                                    mobileController.text,
                                                    passwordController.text);
                                                setState(() {
                                                  changeButton = true;
                                                });
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 600), () {
                                                  Navigator.pushNamed(context,
                                                      MyRoutes.registerRoute);
                                                });
                                              }
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              width: changeButton
                                                  ? 50
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  begin:
                                                      Alignment(-1.00, -0.00),
                                                  end: Alignment(1, 0),
                                                  colors: [
                                                    Color(0xFF07AEB8),
                                                    Color(0xFF17E3CC),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        changeButton ? 50 : 10),
                                              ),
                                              child: changeButton
                                                  ? const Icon(Icons.done,
                                                      color: Colors.white)
                                                  : const Text(
                                                      'Login',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// class LoginPage extends ConsumerStatefulWidget {
//   const LoginPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
// }

// class _LoginPageState extends ConsumerState<LoginPage> {
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
// final AuthController loginDetails = Get.find<AuthController>();
//   String mobileError = EMPTY_STRING;
//   String passwordError = EMPTY_STRING;
//   bool clicked = false;
//   bool _obscureText = true;
//   bool changeButton = false;

//   @override
//   void initState() {
//     super.initState();
//     passwordController = TextEditingController();
//     passwordError = EMPTY_STRING;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final loginDetails = ref.watch(userProvider);
//     // print('loginDetails${loginDetails}');

//     return 
//     Scaffold(
//         backgroundColor: const Color(0xFFF1F5F5),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.sizeOf(context).height,
//             child: Padding(
//               padding: MediaQuery.viewInsetsOf(context),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment(0.98, 0.18),
//                     end: Alignment(-0.98, -0.18),
//                     colors: [Color(0xFF07AEB8), Color(0xFF17E3CC)],
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         width: double.infinity,
//                         alignment: Alignment.topCenter,
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           alignment: Alignment.center,
//                           children: [
//                             Align(
//                               child: Opacity(
//                                 opacity: 0.35,
//                                 child: Container(
//                                   width: 0,
//                                   height: 300,
//                                   margin: const EdgeInsets.only(top: 80),
//                                   decoration: const ShapeDecoration(
//                                     color: Color(0xFF14D9C9),
//                                     shape: OvalBorder(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: -50,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Container(
//                                     margin: const EdgeInsets.only(top: 80),
//                                     child: Image.asset(
//                                         "assets/images/doctor.png")),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         child: Container(
//                           color: Colors.transparent,
//                           child: Container(
//                             height: 450,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFF1F5F5),
//                             ),
//                             // Login Form
//                             child: SingleChildScrollView(
//                               physics: const NeverScrollableScrollPhysics(),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Center(
//                                         child: SizedBox(
//                                           height: 37,
//                                           child: Text(
//                                             'Doctor’s Login',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontSize: 22,
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16.0),
//                                       SizedBox(
//                                         height: 16,
//                                         child: Row(
//                                           children: [
//                                             const SizedBox(width: 10),
//                                             SvgPicture.asset(
//                                                 "assets/icons/mobile.svg"),
//                                             const SizedBox(width: 8),
//                                             const Text(
//                                               'Mobile Number',
//                                               style: TextStyle(
//                                                 color: Color(0xFF222222),
//                                                 fontSize: 13,
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w500,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // ignore: prefer_const_constructors

//                                       SizedBox(height: 10),
//                                       // Mobile number
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Mobile number is required";
//                                           } else if (!RegExp(r'^[0-9]{10}$')
//                                               .hasMatch(value)) {
//                                             return "Please enter a valid 10-digit mobile number";
//                                           }
//                                           return null;
//                                         },
//                                         keyboardType: TextInputType.number,
//                                         controller: mobileController,
//                                         inputFormatters: [
//                                           FilteringTextInputFormatter.allow(
//                                               RegExp(r'[0-9]')),
//                                         ],
//                                         decoration: InputDecoration(
//                                           hintText: "Mobile Number",
//                                           hintStyle: const TextStyle(
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.w400),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                           contentPadding:
//                                               const EdgeInsets.all(16.0),
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide: BorderSide.none,
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide: const BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 208, 244)),
//                                           ),
//                                           errorText:
//                                               clicked ? mobileError : null,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16.0),
//                                       Row(
//                                         children: [
//                                           const SizedBox(width: 10),
//                                           SvgPicture.asset(
//                                               "assets/icons/password.svg"),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'PASSWORD',
//                                             style: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontSize: 13,
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w500,
//                                               height: 0,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10),
//                                       // Password field
//                                       SizedBox(
//                                         child: TextFormField(
//                                           validator: (password) {
//                                             if (password!.isEmpty) {
//                                               return "Password is required";
//                                             } else if (password.length < 8) {
//                                               return "Password should be at least 8 characters";
//                                             } else if (password.length > 15) {
//                                               return "Password should be at most 15 characters";
//                                             } else if (!password
//                                                 .contains(RegExp(r'[A-Z]'))) {
//                                               return "Password should contain at least one uppercase letter";
//                                             } else if (!password.contains(RegExp(
//                                                 r'[!@#$%^&*(),.?":{}|<>]'))) {
//                                               return "Password should contain at least one special character";
//                                             }
//                                             return null;
//                                           },
//                                           controller: passwordController,
//                                           obscureText: _obscureText,
//                                           inputFormatters: [
//                                             LengthLimitingTextInputFormatter(
//                                                 15),
//                                           ],
//                                           decoration: InputDecoration(
//                                             hintText: "Password",
//                                             hintStyle: const TextStyle(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w400),
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                             contentPadding:
//                                                 const EdgeInsets.all(16.0),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               borderSide: BorderSide.none,
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               borderSide: const BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 208, 244)),
//                                             ),
//                                             errorText:
//                                                 clicked ? passwordError : null,
//                                             suffixIcon: IconButton(
//                                               icon: Icon(
//                                                 _obscureText
//                                                     ? Icons.visibility
//                                                     : Icons.visibility_off,
//                                                 color: Colors.black,
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   _obscureText = !_obscureText;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       const SizedBox(height: 20),
//                                       SizedBox(
//                                         child: Center(
//                                           child: GestureDetector(
//                                             onTap: () async {
//                                               print(mobileError);
//                                               print(passwordController);

//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 await loginDetails.loginUser(
//                                                     mobileController.text,
//                                                     passwordController.text);
//                                                 setState(() {
//                                                   changeButton = true;

//                                                 });
//                                                 Future.delayed(
//                                                     const Duration(
//                                                         milliseconds: 600), () {
//                                                   Navigator.pushNamed(context,
//                                                       MyRoutes.registerRoute);
//                                                 });
//                                               }
//                                             },
//                                             child: AnimatedContainer(
//                                               duration: const Duration(
//                                                   milliseconds: 500),
//                                               width: changeButton
//                                                   ? 50
//                                                   : MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       1,
//                                               height: 50,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 gradient: const LinearGradient(
//                                                   begin:
//                                                       Alignment(-1.00, -0.00),
//                                                   end: Alignment(1, 0),
//                                                   colors: [
//                                                     Color(0xFF07AEB8),
//                                                     Color(0xFF17E3CC),
//                                                   ],
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         changeButton ? 50 : 10),
//                                               ),
//                                               child: changeButton
//                                                   ? const Icon(Icons.done,
//                                                       color: Colors.white)
//                                                   : const Text(
//                                                       'Login',
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   String mobileError = EMPTY_STRING;
//   String passwordError = EMPTY_STRING;
//   bool clicked = false;
//   bool _obscureText = true;
//   bool changeButton = false;
//   @override
//   void initState() {
//     super.initState();
//     passwordController = TextEditingController();
//     passwordError = EMPTY_STRING;
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xFFF1F5F5),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.sizeOf(context).height,
//             child: Padding(
//               padding: MediaQuery.viewInsetsOf(context),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment(0.98, 0.18),
//                     end: Alignment(-0.98, -0.18),
//                     colors: [Color(0xFF07AEB8), Color(0xFF17E3CC)],
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         width: double.infinity,
//                         alignment: Alignment.topCenter,
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           alignment: Alignment.center,
//                           children: [
//                             Align(
//                               child: Opacity(
//                                 opacity: 0.35,
//                                 child: Container(
//                                   width: 0,
//                                   height: 300,
//                                   margin: const EdgeInsets.only(top: 80),
//                                   decoration: const ShapeDecoration(
//                                     color: Color(0xFF14D9C9),
//                                     shape: OvalBorder(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: -50,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Container(
//                                     margin: const EdgeInsets.only(top: 80),
//                                     child: Image.asset(
//                                         "assets/images/doctor.png")),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         child: Container(
//                           color: Colors.transparent,
//                           child: Container(
//                             height: 450,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFF1F5F5),
//                             ),
//                             // Login Form
//                             child: SingleChildScrollView(
//                               physics: const NeverScrollableScrollPhysics(),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Center(
//                                         child: SizedBox(
//                                           height: 37,
//                                           child: Text(
//                                             'Doctor’s Login',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontSize: 22,
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16.0),
//                                       SizedBox(
//                                         height: 16,
//                                         child: Row(
//                                           children: [
//                                             const SizedBox(width: 10),
//                                             SvgPicture.asset(
//                                                 "assets/icons/mobile.svg"),
//                                             const SizedBox(width: 8),
//                                             const Text(
//                                               'Mobile Number',
//                                               style: TextStyle(
//                                                 color: Color(0xFF222222),
//                                                 fontSize: 13,
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w500,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // ignore: prefer_const_constructors
//                                       SizedBox(height: 10),
//                                       // Mobile number
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Mobile number is required";
//                                           } else if (!RegExp(r'^[0-9]{10}$')
//                                               .hasMatch(value)) {
//                                             return "Please enter a valid 10-digit mobile number";
//                                           }
//                                           return null;
//                                         },
//                                         keyboardType: TextInputType.number,
//                                         controller: mobileController,
//                                         inputFormatters: [
//                                           FilteringTextInputFormatter.allow(
//                                               RegExp(r'[0-9]')),
//                                         ],
//                                         decoration: InputDecoration(
//                                           hintText: "Mobile Number",
//                                           hintStyle: const TextStyle(
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.w400),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                           contentPadding:
//                                               const EdgeInsets.all(16.0),
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide: BorderSide.none,
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide: const BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 208, 244)),
//                                           ),
//                                           errorText:
//                                               clicked ? mobileError : null,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16.0),
//                                       Row(
//                                         children: [
//                                           const SizedBox(width: 10),
//                                           SvgPicture.asset(
//                                               "assets/icons/password.svg"),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'PASSWORD',
//                                             style: TextStyle(
//                                               color: Color(0xFF222222),
//                                               fontSize: 13,
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w500,
//                                               height: 0,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10),
//                                       // Password field
//                                       SizedBox(
//                                         child: TextFormField(
//                                           validator: (password) {
//                                             if (password!.isEmpty) {
//                                               return "Password is required";
//                                             } else if (password.length < 8) {
//                                               return "Password should be at least 8 characters";
//                                             } else if (password.length > 15) {
//                                               return "Password should be at most 15 characters";
//                                             } else if (!password
//                                                 .contains(RegExp(r'[A-Z]'))) {
//                                               return "Password should contain at least one uppercase letter";
//                                             } else if (!password.contains(RegExp(
//                                                 r'[!@#$%^&*(),.?":{}|<>]'))) {
//                                               return "Password should contain at least one special character";
//                                             }
//                                             return null;
//                                           },
//                                           controller: passwordController,
//                                           obscureText: _obscureText,
//                                           inputFormatters: [
//                                             LengthLimitingTextInputFormatter(
//                                                 15),
//                                           ],
//                                           decoration: InputDecoration(
//                                             hintText: "Password",
//                                             hintStyle: const TextStyle(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w400),
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                             contentPadding:
//                                                 const EdgeInsets.all(16.0),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               borderSide: BorderSide.none,
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               borderSide: const BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 208, 244)),
//                                             ),
//                                             errorText:
//                                                 clicked ? passwordError : null,
//                                             suffixIcon: IconButton(
//                                               icon: Icon(
//                                                 _obscureText
//                                                     ? Icons.visibility
//                                                     : Icons.visibility_off,
//                                                 color: Colors.black,
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   _obscureText = !_obscureText;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       const SizedBox(height: 20),
//                                       SizedBox(
//                                         child: Center(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 setState(() {
//                                                   changeButton = true;
//                                                 });
//                                                 Future.delayed(
//                                                     const Duration(
//                                                         milliseconds: 600), () {
//                                                   Navigator.pushNamed(context,
//                                                       MyRoutes.registerRoute);
//                                                 });
//                                               }
//                                             },
//                                             child: AnimatedContainer(
//                                               duration: const Duration(
//                                                   milliseconds: 500),
//                                               width: changeButton
//                                                   ? 50
//                                                   : MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       1,
//                                               height: 50,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 gradient: const LinearGradient(
//                                                   begin:
//                                                       Alignment(-1.00, -0.00),
//                                                   end: Alignment(1, 0),
//                                                   colors: [
//                                                     Color(0xFF07AEB8),
//                                                     Color(0xFF17E3CC),
//                                                   ],
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         changeButton ? 50 : 10),
//                                               ),
//                                               child: changeButton
//                                                   ? const Icon(Icons.done,
//                                                       color: Colors.white)
//                                                   : const Text(
//                                                       'Login',
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }