import 'package:aaacyborg/controller/forgetpassword_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  final TextEditingController emailController = TextEditingController();
  String _message = '';

  @override
  void initState() {
    super.initState();
    _getMessage();
  }

  ///Message From API
  Future<void> _getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? message = prefs.getString('message');

    setState(() {
      _message = message ?? '';
      if (kDebugMode) {
        print(message);
      }
    });
  }

  ///Validation
  void _submitForm(){
    var email = forgetPasswordController.emailController.text;

    if(email.isEmpty){
      Fluttertoast.showToast(
        msg: 'Please fill in all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }else{
      final snackBar = SnackBar(
        content: Text(_message),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      forgetPasswordController.forgetpassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///text
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Forgot Password" , style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),

          ///mail
          Padding(
            padding: const EdgeInsets.only(top: 8.0 , right: 20, left: 20),
            child: TextField(
              controller: forgetPasswordController.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                labelText: "Email",
                hintText: "Enter Your Ragister Email",
              ),
            ),
          ),
          const SizedBox(height: 30),

          ///submit btn
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text("submit")),
          ),
        ],
      ),

    );
  }
}
