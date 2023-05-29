import 'dart:async';
import 'package:aaacyborg/auth/login_api.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';

Future main() async {



  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const LoginOne()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: 100,height: 100,
          child: const Image(image: AssetImage(CustomImages.rabbit) , width: 100),
        ),
      ),
    );
  }
}
