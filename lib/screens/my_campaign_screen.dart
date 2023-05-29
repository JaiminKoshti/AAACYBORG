import 'package:flutter/material.dart';

class MyCampaignScreen extends StatefulWidget {
  const MyCampaignScreen({Key? key}) : super(key: key);

  @override
  State<MyCampaignScreen> createState() => _MyCampaignScreenState();
}

class _MyCampaignScreenState extends State<MyCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Only support up to 3 takes at the same time . Please delete the tasks",
                style: TextStyle(color: Colors.red, fontSize: 15)),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: TextField(textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          hintText: "Input Youtube video url",
                          hintStyle: TextStyle(fontSize: 18)),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text("ADD"),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
