import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewtube/webviewtube.dart';
import '../utils/apis.dart';

class PrivacyController extends GetxController{

  Future<void> privacy() async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.privacy);
      Map body = {
        /*'username': userNameController.text,
        'password': passwordController.text,
        'fcm_token': forTokenController,*/
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
            print(json['data'][0]['url']);
          }

          var url1 = json['data'][0]['url'];
         /* FutureBuilder<String>(
            builder:
                (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return
              }
            },
          );*/
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
          // Delay the WhatsApp opening for demonstration purposes
          await Future.delayed(const Duration(seconds: 2));
          if (await canLaunch(url1)) {
            launch(url1 as String);
          } else {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Could not launch WhatsApp.'),
                  actions: [
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          Get.back();/*
          Navigator.of(context).pop();*/


      } else {
        if (kDebugMode) {
          print(jsonDecode(response.body)["message"]);
          print(response.statusCode);
        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
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