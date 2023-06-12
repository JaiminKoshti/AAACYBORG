import 'dart:async';
import 'package:aaacyborg/screens/auth/login/login_screen.dart';
import 'package:aaacyborg/screens/auth/ragister/ragister_screen.dart';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> setupSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    // This is the first app launch, set initial login state
    await prefs.setBool('isFirstLaunch', false);
    await prefs.setBool('isLoggedIn', false);
  }
}

class _SplashScreenState extends State<SplashScreen> {

  String _token = '';

  ///Token From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    setState(() {
      _token = token ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Delay for 2 seconds to show the splash screen
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the appropriate screen
    if (_token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    /*// Simulate a delay in checking the user's login state
    Future.delayed(const Duration(seconds: 2), () {
      final isLoggedIn = userProvider.isLoggedIn;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => userProvider.isLoggedIn ? HomeScreen() : LoginScreen()
        ),
      );
    });*/

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: 100,
          height: 100,
          child:
              const Image(image: AssetImage(CustomImages.rabbit), width: 100),
        ),
      ),
    );
  }
}
