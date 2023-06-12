import 'dart:convert';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/login/provider.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String forTokenController = "1234567890";

  Future<void> loginWithEmail() async {
    //final userProvider = Provider.of<UserProvider>(context as BuildContext);

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);
      Map body = {
        'username': userNameController.text,
        'password': passwordController.text,
        'fcm_token': forTokenController,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.statusCode);
          print(json["status"]);
        }

        if (json['status'] == true) {
          if (kDebugMode) {
            print(json['data']);
          }

          var dataArray = (json['data'] as List);
          if (dataArray.isNotEmpty) {
            var data = dataArray[0];
            var token = data['token'];

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);

            /*Future.delayed(const Duration(seconds: 2), () {
              final accessToken = '$token';
              userProvider.login(accessToken);
            });*/
            Get.to(const HomeScreen());
            userNameController.clear();
            passwordController.clear();
            /*final userProvider =
                Provider.of<UserProvider>(Get.context!, listen: false);
            userProvider.setUser(userNameController.text);
            userNameController.clear();
            passwordController.clear();*/
            /*forTokenController;*/
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
