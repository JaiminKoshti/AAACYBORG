import 'dart:convert';
import 'package:aaacyborg/screens/auth/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/auth/login/provider.dart';
import '../utils/apis.dart';

class ForgetPasswordController extends GetxController{
  TextEditingController emailController = TextEditingController();

  Future<void> forgetpassword() async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.forgetpassword);
      Map body = {
        'email': emailController.text,
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.statusCode);
          print(json["status"]);
          print(json["message"]);

        }

        if (json['status'] == true) {
          if (kDebugMode) {
            print(json['data']);
          }

          var message = json['message'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          print(json["message"]);
          await prefs.setString('message', message);

          Get.to(const LoginScreen());
          final userProvider =
          Provider.of<UserProvider>(Get.context!, listen: false);
          userProvider.setUser(emailController.text);
          emailController.clear();

          var dataArray = (json['data'] as List);
          /*if (dataArray.isNotEmpty) {
            var data = dataArray[0];
            var message = json['message'];

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('message', message);

            Get.to(const HomeScreen());
            final userProvider =
            Provider.of<UserProvider>(Get.context!, listen: false);
            userProvider.setUser(emailController.text);
            emailController.clear();
          }*/
        } else {
          if (kDebugMode) {
            print(json['status']);
          }
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        if (kDebugMode) {
          print(jsonDecode(response.body)["message"]);
          print(response.statusCode);
        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}