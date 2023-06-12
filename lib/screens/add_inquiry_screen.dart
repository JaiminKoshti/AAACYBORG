import 'package:aaacyborg/controller/inquiry_controller.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInquiryScreen extends StatefulWidget {
  const AddInquiryScreen({Key? key}) : super(key: key);

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  final InquiryController _inquiryController = Get.put(InquiryController());
  final int maxLength = 10;
  String _message = "";

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ///Token From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? message = prefs.getString('message');

    setState(() {
      _message = message ?? 'ok';
    });
  }

  ///validation
  void _submitForm() {
    var firstName = _inquiryController.firstNameController.text;
    var lastName = _inquiryController.lastNameController.text;
    var email = _inquiryController.emailNameController.text;
    var phone = _inquiryController.phoneController.text;
    var inquiry = _inquiryController.messageController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        inquiry.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill in all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      _inquiryController.inquiry();
      Fluttertoast.showToast(
        msg: _message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      if (kDebugMode) {
        print('Done!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text("Inquiry"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Image(image: AssetImage(CustomImages.rabbit) , width: 100),
            const SizedBox(height: 30),
            /// names
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 8),
              child: Row(
                children: <Widget>[
                  /// first name
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 10, left: 20),
                      child: TextField(
                        controller: _inquiryController.firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "First Name",
                          hintText: "Enter Your first name",
                        ),
                      ),
                    ),
                  ),

                  ///last name
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 10,
                        right: 20,
                      ),
                      child: TextField(
                        controller: _inquiryController.lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Last Name",
                          hintText: "Enter Your Last Name",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///email
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
              child: TextField(
                controller: _inquiryController.emailNameController,
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

            ///phone number
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
              child: TextField(
                controller: _inquiryController.phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(maxLength),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Phone",
                  hintText: "Enter Your Phone Number",
                ),
              ),
            ),
            const SizedBox(height: 10),

            ///inquiry
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
              child: SizedBox(
                height: 100,
                child: TextFormField(
                  maxLines: 3,
                  controller: _inquiryController.messageController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[\s\n]')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Inquiry",
                    hintText: "Add Your Inquiry here",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            ///submit btn
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    //_inquiryController.inquiry();
                    _submitForm();
                  },
                  child: const Text("submit")),
            ),
          ],
        ),
      ),
    );
  }
}
