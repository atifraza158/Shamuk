import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String email = "shamuk@gmail.com";
  String phonePaK = "+971- 554153521";
  String phoneDubai = "03199290460";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Shamuk Info",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Contact Info",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                var emailAndroid = Uri.parse("mailto:$email");
                await launchUrl(emailAndroid);
              },
              child: Text(
                email,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                var emailAndroid = Uri.parse("tel:$phonePaK");
                await launchUrl(emailAndroid);
              },
              child: Text(
                phonePaK,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                var emailAndroid = Uri.parse("tel:$phoneDubai");
                await launchUrl(emailAndroid);
              },
              child: Text(
                phoneDubai,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Shamuk Locations",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Dubai : Al Sharaf Tower 1 , Office No. 802 , Al Barsha Hieghts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Pakistan : Office No. 302 , 22nd Commercial Street , DHA Phase 2 Extention Karachi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
