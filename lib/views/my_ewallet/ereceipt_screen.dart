import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class EreceiptScreen extends StatefulWidget {
  const EreceiptScreen({Key? key}) : super(key: key);

  @override
  State<EreceiptScreen> createState() => _EreceiptScreenState();
}

class _EreceiptScreenState extends State<EreceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "E-Receipt",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
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
                    radius: 25,
                    backgroundImage: NetworkImage(
                      "https://static-01.daraz.pk/p/21aa749ce98fecc4f5d6c14bbdf80e7d.jpg",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Stylo Bag",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Qty = 1",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Color",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: Color.fromARGB(255, 7, 89, 156),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Size = 40",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Amount"),
                      Text("Rs.9999/-"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Promo"),
                      Text("Rs.1099"),
                    ],
                  ),
                  const Divider(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Total"),
                      Text("Rs.8899"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: themewhitecolor,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: themegreycolor,                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Payment Methods"),
                      Text("My E-Wallet"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Date"),
                      Text("Dec 15, 2022 | 10:00 AM"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Transaction ID"),
                      Text("Sk7563115972"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Status"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: Palette.themecolor,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const Text(
                          "Paid",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
