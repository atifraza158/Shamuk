import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_text_button.dart';

class SendMessageFormScreen extends StatefulWidget {
  const SendMessageFormScreen({Key? key}) : super(key: key);

  @override
  State<SendMessageFormScreen> createState() => _SendMessageFormScreenState();
}

class _SendMessageFormScreenState extends State<SendMessageFormScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themegreytextcolor,
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Row(
              children: [
                CustomIconButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: themewhitecolor,
                    child: Icon(
                      Icons.close,
                      color: themegreytextcolor,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Contact Pro",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                CustomTextButton(
                  buttonText: "Send".toUpperCase(),
                  onTap: () {},
                  textstyle: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: themedarkgreycolor,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://st.hzcdn.com/simgs/7753f6320ed7a852_3-6756/_.jpg",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SGDI - Sarah Gallop Design Inc.",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: themeorangecolor,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "121 Review and Ratings",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      labelText: "Email Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Your mobile phone number",
                      labelText: "Your mobile phone number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Your project postcode",
                      labelText: "Your project postcode",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Your Message",
                      alignLabelWithHint: true,
                    ),
                  ),
                  CheckboxListTile(
                    value: value,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Palette.themecolor,
                    title: const Text(
                      "I confirm this is a personal project enquiry and not a promotional message or solicitation",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                      ),
                    ),
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    side: const BorderSide(
                      color: themegreytextcolor,
                      width: 2,
                    ),
                    onChanged: (bool? newValue) {
                      setState(() {
                        value = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text.rich(
                    TextSpan(
                      text: "By clicking or tapping \"Send\", I agree to the ",
                      children: [
                        TextSpan(
                          text: "Shamuk Terms of Use ",
                          style: TextStyle(
                            color: Palette.themecolor,
                          ),
                        ),
                        TextSpan(
                          text: "and the ",
                          style: TextStyle(
                            color: themeblackcolor,
                          ),
                        ),
                        TextSpan(
                          text: "Shamuk Privacy Policy ",
                          style: TextStyle(
                            color: Palette.themecolor,
                          ),
                        ),
                        TextSpan(
                          text:
                              "as well as to receive text messages and calls from Shamuk and professionals about my projects under these terms.",
                          style: TextStyle(
                            color: themeblackcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
