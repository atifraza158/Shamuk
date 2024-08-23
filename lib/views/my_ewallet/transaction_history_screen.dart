import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransactioHistoryScreen extends StatefulWidget {
  const TransactioHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactioHistoryScreen> createState() =>
      _TransactioHistoryScreenState();
}

class _TransactioHistoryScreenState extends State<TransactioHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Transaction History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      "https://static-01.daraz.pk/p/21aa749ce98fecc4f5d6c14bbdf80e7d.jpg",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stylo Bag",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dec 15, 2022 | 10:00 Am",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$265",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }));
  }
}
