import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({Key? key}) : super(key: key);

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  final _key = GlobalKey<FormState>();
  final fullnameC = TextEditingController();
  final emailC = TextEditingController();
  final subjectC = TextEditingController();
  final messageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSimpleRoundedButton(
            onTap: () {
              if (_key.currentState!.validate()) {
                final contactProvider =
                    Provider.of<auth_pro>(context, listen: false);
                    contactProvider.userContactUsFunc(fullnameC.text, emailC.text, subjectC.text, messageC.text, context);

              }
            },
            buttoncolor: Palette.themecolor,
            height: kMinInteractiveDimension,
            width: MediaQuery.of(context).size.width * 0.85,
            borderRadius: BorderRadius.circular(12),
            child: const Text(
              "Submit",
              style: TextStyle(
                color: themewhitecolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Full Name",
                    style: TextStyle(
                      color: themeblackcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: fullnameC,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: Palette.themecolor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themewhitecolor,
                        hintText: "Full Name",
                        hintStyle: const TextStyle(fontSize: 15),
                        errorStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Full name is empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: themeblackcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: emailC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: Palette.themecolor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themewhitecolor,
                        hintText: "Email Address",
                        hintStyle: const TextStyle(fontSize: 15),
                        errorStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email is empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("email format is not correct.");
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Subject",
                    style: TextStyle(
                      color: themeblackcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: subjectC,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: Palette.themecolor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themewhitecolor,
                        hintText: "Subject",
                        hintStyle: const TextStyle(fontSize: 15),
                        errorStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Subject is empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Message",
                    style: TextStyle(
                      color: themeblackcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: messageC,
                      keyboardType: TextInputType.name,
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      cursorColor: Palette.themecolor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themewhitecolor,
                        hintText: "Message",
                        hintStyle: const TextStyle(fontSize: 15),
                        errorStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Subject is empty";
                        } else {
                          return null;
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
