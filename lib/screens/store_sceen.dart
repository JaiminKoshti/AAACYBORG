import 'package:aaacyborg/screens/buy_point_screen.dart';
import 'package:aaacyborg/screens/delete_account_screen.dart';
import 'package:aaacyborg/screens/persnol_info_screen.dart';
import 'package:aaacyborg/screens/privacy_policy_screen.dart';
import 'package:aaacyborg/widgets/dark_mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/widgets.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Buy point
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 87,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage(CustomImages.diamond),
                                width: 30)),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(CustomText.buy_point,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BuyPointScreen()));
                },
              ),
            ),

            /// persnol info
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 87,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage(CustomImages.personal_info),
                              width: 30,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(
                            "Persnol information",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersnolInfoScreen()));
                },
              ),
            ),

            /// dark mode
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 87,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              CustomIcons.dark_mode,
                              size: 34,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(
                            "Dark mode",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: darkModeProvider.isDarkMode,
                          activeColor: Colors.black,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              darkModeProvider.toggleDarkMode();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            ///privacy policy
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 87,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage(CustomImages.privacy_policy),
                                width: 30)),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(CustomText.privacy_policy,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen()));
                },
              ),
            ),

            ///contact us
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 70,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Image(
                              image: AssetImage(CustomImages.contact_us),
                              width: 30),
                        ),
                        Text(CustomText.context_us)
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  await Share.share("Mb Infoways");
                },
              ),
            ),

            ///delete account
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 12, right: 12),
              child: InkWell(
                child: SizedBox(
                  height: 87,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage(CustomImages.delete_account),
                              width: 30,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(
                            "Delete Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeleteAccountScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
