import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              primary: false,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return PhysicalModel(
                  color: themewhitecolor,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(15),
                  child: ExpansionTile(
                    iconColor: Palette.themecolor,
                    textColor: Palette.themecolor,
                    collapsedTextColor: themeblackcolor,
                    collapsedIconColor: themeblackcolor,
                    childrenPadding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    title: Text(
                      index == 0
                          ? "What is Shamuk"
                          : index == 1
                              ? "How to use shamuk"
                              : index == 2
                                  ? "How do i cancel a orders product"
                                  : index == 3
                                      ? "Is Shamuk free to use"
                                      : "How to add Promo on Shamuk?",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: const [
                      Divider(color: themedarkgreycolor),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
