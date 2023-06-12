import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ///Share
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
            child: InkWell(
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(image: AssetImage(CustomImages.share)),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Share',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                await Share.share("hey !");
              },
            ),
          ),

          ///WhatsApp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 2),
            child: InkWell(
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(image: AssetImage(CustomImages.whatsApp)),
                      ),
                      SizedBox(width: 16),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'WhatsApp',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );

                // Delay the WhatsApp opening for demonstration purposes
                await Future.delayed(const Duration(seconds: 2));

                // Launch WhatsApp
                const phoneNumber = "+971588808686";
                const message = "Hello!";
                final url =
                    'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  showDialog(
                    context: context,
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
                // Close the loader
                Navigator.of(context).pop();
              },
            ),
          ),
          /*Center(
              child: ElevatedButton(
            onPressed: () async {
              // Show a loader

            },
            child: const Text('Open WhatsApp'),
          )),*/
        ],
      ),
    );
  }
}
