import 'dart:convert';
import 'package:aaacyborg/screens/auth/login/login_screen.dart';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController{
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String forTokenController = "123456789";

  Future<void> registerWithEmail() async {
    try{
      var headers = {'content-Type' : 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerEmail);
      Map body = {
        'first_name' : firstNameController.text,
        'last_name' : lastNameController.text,
        'email' : emailNameController.text,
        'username' : userNameController.text,
        'password' : passwordController.text,
        'phone' : phoneController.text,
        'fcm_token' : forTokenController,
      };

      http.Response response = await http.post(url , body: jsonEncode(body) , headers: headers);

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        if(json['status'] == true){
          /*var dataArray = (json['data'] as List);
          // if(dataArray.isNotEmpty){
          //   var data = dataArray[0];
          *//*var data = dataArray[0];
            var token = data['token'];*/

            if (kDebugMode) {
              print(jsonDecode(response.body)["message"]);
            }

            var dataArray = (json['data'] as List);
            var token = dataArray[0]['token'];
            if (kDebugMode) {
              print(token);
            }

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('tokenRegister', token);

            Get.to(const LoginScreen());
            firstNameController.clear();
            lastNameController.clear();
            emailNameController.clear();
            userNameController.clear();
            passwordController.clear();
            phoneController.clear();


         /* }else{
            debugPrint("dataArray is empty");
          }*/
        }else{
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      }else {
        if (kDebugMode) {
          print(jsonDecode(response.body)["message"]);
          print(response.statusCode);

        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }

    } catch (e){
      Get.back();
      showDialog(context: Get.context!, builder: (context) {
        return SimpleDialog(
          title: const Text('Error'),
          contentPadding: const EdgeInsets.all(20),
          children: [Text(e.toString())],
        );
      });
    }
  }
}