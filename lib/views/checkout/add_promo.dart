import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';

class AddPromo extends StatefulWidget {
  const AddPromo({Key? key}) : super(key: key);

  @override
  State<AddPromo> createState() => _AddPromoState();
}

class _AddPromoState extends State<AddPromo> {
  int? selectvalue;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Promo",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Container(
          height: 75,
          decoration: const BoxDecoration(
            color: themewhitecolor,
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomRoundedButton(
                buttonText: "Apply",
                onTap: () {
                  // RouteNavigator.route(context, CheckOutScreen());
                },
                buttoncolor: Palette.themecolor,
                buttontextcolor: themewhitecolor,
                height: kMinInteractiveDimension,
                width: MediaQuery.of(context).size.width * 0.85,
              )),
        ),
        body: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20.0),
              itemCount: 2,
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
                          backgroundColor: themeblackcolor,
                          radius: 15,
                          child: Icon(
                            Icons.discount,
                            color: Palette.themecolor,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Special 25 % Off",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                           "Special promo only today!",
                            style: TextStyle(
                                color: themegreytextcolor, fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
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
