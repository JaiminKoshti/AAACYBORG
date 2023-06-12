import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/auth/login/login_screen.dart';
import '../utils/apis.dart';

class ProfileController extends GetxController{

  Future<void> profile() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.profile);
      Map body = {
        'token': token,
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (kDebugMode) {
        print("profile ....$token");
      }

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.statusCode);
          print(json["status"]);
        }

        if (json['status'] == true) {
          if (kDebugMode) {
            print(json['data'][0]['email']);
          }

          var dataArray = (json['data']);
          if (dataArray.isNotEmpty) {



            var email = dataArray[0]['email'];
            if (kDebugMode) {
              print("<<<<<<< $email");
            }

            var points =json['data'][0]['point'];
            if (kDebugMode) {
              print("points : $points");
            }

            var vipExpiryDate = dataArray[0]['vip_expiry_date'];
            if (kDebugMode) {
              print(vipExpiryDate);
            }

            /*var point = dataArray[0]['point'];
            print(point);*/

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('pointProfile', points);
            await prefs.setString('email', email);
            await prefs.setString('vip_expiry_date', vipExpiryDate);

            /*Get.to(const HomeScreen());*/

          }
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
              children: [Text(e.toString()) , SizedBox(width: 10,
                child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(const LoginScreen());
                    },
                    child: const Text("Login")),
              )],
            );
          });
    }
  }
}