import 'dart:convert';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginOne extends StatefulWidget {
  const LoginOne({Key? key}) : super(key: key);

  @override
  State<LoginOne> createState() => _LoginOneState();
}


class _LoginOneState extends State<LoginOne> {
  String token = '';
  String message = '';
  String errorMessage = '';
  String status = '';
  String userType = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /*Future<void> userlogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    final response = await BaseClient.loginWithApi(email, password, message);

    var responseData = jsonDecode();
    var message = responseData['message'];
    var status = responseData['status'];

    if(response!.values == '200'){
      var data = responseData['data'][0];
      var token = data['Token'];
    }
  }*/

  ///working
  Future<void> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    final response = await http.post(Uri.parse('https://cnt.hiredeveloper.today/api/login'),
        body: {'email': email, 'password': password  , 'message': message});

    if (response.statusCode == 200) {
      // Login successful
      var responseData = jsonDecode(response.body);
      var message = responseData['message'];
      var status = responseData['status'];
      if (status == "200") {
        var data = responseData['data'][0];
        var token = data['Token'];
        setState(() {
          this.token = token;
          this.message = message;
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          this.message = message;
        });
      }
    } else {
      // Login failed
      var errorMessage = 'Login failed';
      var errorData = jsonDecode(response.body);
      errorMessage = errorData['message'];
      setState(() {
        token = '';
        this.errorMessage = errorMessage;
      });
    }
  }

  /*void fetchLoginDetails() async {
    final response = await BaseClient.fetchLoginDetails("200");

    if (response == "200") {
      setState(() {
        status = response!["status"].toString();
        message = response["message"];

        final data = response["data"];
        if (data != null && data.isNotEmpty) {
          token = data[0]["Token"];
          userType = data[0]["userType"];
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            const Center(
                child: Text("Login with Email",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "password",
                  hintText: "Enter Your password",
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: const Text("submit")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(token),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
