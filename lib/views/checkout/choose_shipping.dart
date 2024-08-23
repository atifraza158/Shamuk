import 'package:flutter/material.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/checkout/checkout_screen.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';

class ChooseShippingScreen extends StatefulWidget {
  const ChooseShippingScreen({Key? key}) : super(key: key);

  @override
  State<ChooseShippingScreen> createState() => _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  int? selectvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 0,
          title: const Text(
            "Choose Shipping",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRoundedButton(
              buttonText: "Apply",
              onTap: () {
                Navigator.pop(context);
              },
              buttoncolor: Palette.themecolor,
              buttontextcolor: themewhitecolor,
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.85,
            )),
        body: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: themegreycolor,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: themegreycolor,
                        child: CircleAvatar(
                          backgroundColor: Palette.themecolor,
                          radius: 15,
                          child: Icon(
                            Icons.room,
                            color: themewhitecolor,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index == 0
                                ? "Economy"
                                : index == 1
                                    ? "Super"
                                    : index == 2
                                        ? "Master"
                                        : "Premium",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            index == 0
                                ? "Estimated Time. 2 to 3 months"
                                : index == 1
                                    ? "Estimated Time. 5 to 6 weeks"
                                    : index == 2
                                        ? "Estimated Time. 2 weeks"
                                        : "Estimated Time. 2 to 3 days",
                            style: const TextStyle(
                                color: themegreytextcolor, fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        index == 0
                            ? "Rs.2999/-"
                            : index == 1
                                ? "Rs.7999/-"
                                : index == 2
                                    ? "Rs.19999/-"
                                    : "Rs.23999",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Radio(
                        activeColor: Palette.themecolor,
                        value: index,
                        groupValue: selectvalue,
                        onChanged: (value) {
                          setState(
                            () {
                              selectvalue = index;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          ],
        ));
  }
}
