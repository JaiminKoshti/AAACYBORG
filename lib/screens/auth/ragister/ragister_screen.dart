import 'package:aaacyborg/controller/registration_controller.dart';
import 'package:aaacyborg/screens/auth/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controller/privacy_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  final PrivacyController privacyController = Get.put(PrivacyController());

  var isLogin = false.obs;

  bool _isPasswordVisible = false;

  bool isChecked = false;

  ///validation
  void _submitForm() {
    var firstName = registrationController.firstNameController.text;
    var lastName = registrationController.lastNameController.text;
    var email = registrationController.emailNameController.text;
    var userName = registrationController.userNameController.text;
    var phoneNo = registrationController.phoneController.text;
    var password = registrationController.passwordController.text;

    if (firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
        userName.isEmpty &&
        phoneNo.isEmpty &&
        password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill in all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      if (isChecked == true) {
        // One or more fields are empty, perform error handling
        if (kDebugMode) {
          print('data submited!');
        }
        registrationController.registerWithEmail();
      } else {
        Fluttertoast.showToast(
          msg: 'Please check privacy policy',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      if (kDebugMode) {
        print('One or more fields are empty!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              const Padding(
                padding: EdgeInsets.all(20),
                child:
                    Image(image: AssetImage("assets/download.png"), width: 100),
              ),

              ///text
              const Center(
                  child: Text("Register",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 25),

              /// names
              Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 8),
                child: Row(
                  children: <Widget>[

                    /// first name
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 10, left: 20),
                        child: TextField(
                          controller:
                              registrationController.firstNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "First Name",
                            hintText: "Enter Your first name",
                          ),
                        ),
                      ),
                    ),

                    ///last name
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 10,
                          right: 20,
                        ),
                        child: TextField(
                          controller: registrationController.lastNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Last Name",
                            hintText: "Enter Your Last Name",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///email
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                child: TextField(
                  controller: registrationController.emailNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email",
                    hintText: "Enter Your Ragister Email",
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ///user name
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                child: TextField(
                  controller: registrationController.userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "User Name",
                    hintText: "Enter Your User Name",
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ///password
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: registrationController.passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      suffix: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "password",
                      hintText: "Enter Your password",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ///phone number
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                child: TextField(
                  controller: registrationController.phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Phone",
                    hintText: "Enter Your Phone Number",
                  ),
                ),
              ),

              ///privacyPolicy
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      //fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    InkWell(
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        privacyController.privacy();
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              ///submit btn
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      _submitForm();
                      //registrationController.registerWithEmail();
                    },
                    child: const Text("submit")),
              ),
              const SizedBox(height: 20),

              ///already have an account
              GestureDetector(
                child: const SizedBox(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Text("Already Hava an account?",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
