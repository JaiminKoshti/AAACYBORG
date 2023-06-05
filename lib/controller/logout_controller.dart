import 'dart:convert';
import 'package:aaacyborg/screens/auth/login/login_screen.dart';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.logoutEmail);
      Map body = {
        'token': Token.toString(),
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        // Logout successful
        if (kDebugMode) {
          print(response.statusCode == 200);
        }
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          var dataArray = (json['data'] as List);
          if (dataArray.isNotEmpty) {
            if (kDebugMode) {
              print('Logout successful');
            }

            Get.offAll(const LoginScreen());
            if (kDebugMode) {
              print(jsonDecode(response.body)["message"]);
            }
          }
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        // Logout failed
        if (kDebugMode) {
          print('Logout failed');
        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      // Error occurred during logout
      if (kDebugMode) {
        print('Error during logout: $e');
      }
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
