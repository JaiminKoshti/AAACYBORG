import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Text("Privacy Policy for AAACYBORG",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }
}