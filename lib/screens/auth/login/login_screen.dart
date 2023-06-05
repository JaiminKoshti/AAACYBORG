import 'package:aaacyborg/controller/login_controller.dart';
import 'package:aaacyborg/screens/auth/forgetpassword/forgotpassword_screen.dart';
import 'package:aaacyborg/screens/auth/ragister/ragister_screen.dart';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LoginController loginController = Get.put(LoginController());

  String token = '';
  String message = '';
  String errorMessage = '';
  String status = '';
  String userType = '';
  bool _isPasswordVisible = false;
  bool isChecked = false;

  /*final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();*/

  final String _loginMessage = '';

  /*void validateAndLogin() {
    String username = userController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      loginController.loginWithEmail();
    } else {
      Fluttertoast.showToast(
        msg: 'Please fill in all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }*/

  ///validation
  void _submitForm() {
    var user = loginController.userNameController.text;
    var password = loginController.passwordController.text;
    if (user.isEmpty && password.isEmpty) {
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
        print('data submited!');
        loginController.loginWithEmail();
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
      print('One or more fields are empty!');
    }
  }

  ///login with Google
  void _loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAccountProvider =
            Provider.of<GoogleAccountProvider>(context, listen: false);
        googleAccountProvider.setUser(googleUser);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (error) {
      debugPrint('Login with Google failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              ///img
              const Padding(
                padding: EdgeInsets.all(20),
                child:
                    Image(image: AssetImage("assets/download.png"), width: 100),
              ),

              ///text
              const Center(
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 25),

              ///email / user
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: loginController.userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email / User Name",
                    hintText: "Enter Your Ragister Email / User Name",
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ///password
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: loginController.passwordController,
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

              ///forgot password
              GestureDetector(
                child: const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text('forgot password?',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.right),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()));
                },
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
                    const Text(
                      "Privacy Policy",
                      style: TextStyle(decoration: TextDecoration.underline),
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
                    onPressed: () {
                      _submitForm();
                      //validateAndLogin();
                    },
                    child: const Text("submit")),
              ),

              /// Login in with Google
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: 190,
                  height: 60,
                  child: InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      shadowColor: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                                image: AssetImage(CustomImages.google),
                                width: 23),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.0),
                            child: Text(
                              "Login in with Google",
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _loginWithGoogle(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),

              ///Don't have an account
              GestureDetector(
                child: const SizedBox(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Text("Don't Hava an account?",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
              ),

              ///token
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(token),
              ),

              ///message from API
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _loginMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
