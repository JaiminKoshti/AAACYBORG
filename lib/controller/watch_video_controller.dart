import 'dart:convert';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

class WatchVideoController extends GetxController {
  Future<void> watchVideo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.watchvideo);
      Map body = {
        'token': token
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        // Logout successful

        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          //var dataArray = (json['data']);
          var dataArray = (json['data'] as List );
          print(dataArray);

          if(dataArray.isNotEmpty){

            if (kDebugMode) {
              print('>>>>>>>>>>>>>>${json['message']}');
              print('>>>>>>>>>>>>>>${dataArray[0]['required_watch_seconds']}');
              print('>>>>>>>>>>>>>>${dataArray[0]['points']}');
            }
            var message = json['message'];
            var required_watch_seconds = dataArray[0]['required_watch_seconds'];
            var pointsWatchVideo = dataArray[0]['points'];

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('message', message);
            await prefs.setInt('required_watch_seconds', required_watch_seconds);
            await prefs.setInt('pointsWatchVideo', pointsWatchVideo);

          }
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        // Logout failed
        /*if (kDebugMode) {
          print('Logout failed');
        }*/
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      // Error occurred during logout
      /*if (kDebugMode) {
        print('Error during logout: $e');
      }*/
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