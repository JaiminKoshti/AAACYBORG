import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class BuyPointScreen extends StatelessWidget {
  const BuyPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Text(
            "AAACYBORG",
          ),
        ),
        leading: const Icon(Icons.ac_unit, size: 30, color: Colors.white70),
        actions: const [
          Center(child: Text("600", textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Image(
                image: AssetImage(CustomImages.diamond),
                width: 30),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 58),

            ///text
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(13)),
                  child: const Padding(
                    padding: EdgeInsets.all(11.0),
                    child: Text(
                      "have purchased diamonds , please contact us if an error occurs , thank ypu you |2jiuggl@gmail.com",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),

            ///6000
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 2),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(13)),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("6000"),
                        ),
                        Image(
                            image: AssetImage(CustomImages.diamond),
                            width: 30),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text("1 USD"),
                        ),
                      ],
                    )),
              ),
            ),

            ///100,000
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(13)),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("100,000"),
                        ),
                        Image(
                            image: AssetImage(CustomImages.diamond),
                            width: 30),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text("10 USD"),
                        ),
                      ],
                    )),
              ),
            ),

            ///1,500,000
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 2),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(13)),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("1,500,000"),
                        ),
                        Image(
                            image: AssetImage(CustomImages.diamond),
                            width: 30),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text("100 USD"),
                        ),
                      ],
                    )),
              ),
            ),

            ///4,000,000
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(13)),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("4,000,000"),
                        ),
                        Image(
                            image: AssetImage(CustomImages.diamond),
                            width: 30),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text("200 USD"),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
