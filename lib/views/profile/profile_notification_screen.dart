import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class ProfileNotificationScreen extends StatefulWidget {
  const ProfileNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileNotificationScreen> createState() =>
      _ProfileNotificationScreenState();
}

class _ProfileNotificationScreenState extends State<ProfileNotificationScreen> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 0,
          title: const Text(
            "Notification",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 6,
          ),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "General",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                      activeColor: Palette.themecolor,
                      value: value,
                      onChanged: (index) {
                        setState(() {
                          value = index;
                        });
                      }),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
        ));
  }
}
