import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class TrackOrder extends StatefulWidget {
  final String title;
  final String images;
  final String price;
  const TrackOrder({
    Key? key,
    required this.title,
    required this.images,
    required this.price,
  }) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int currentstep = 0;
  List<Step> getStep() => [
        Step(
          isActive: currentstep >= 0,
          title: const Icon(Icons.production_quantity_limits),
          content: const Center(
            child: Text(
              "Packet in Delivery",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Step(
          isActive: currentstep >= 1,
          title: const Icon(Icons.fire_truck),
          content: Container(),
        ),
        Step(
          isActive: currentstep >= 2,
          title: const Icon(Icons.delivery_dining),
          content: Container(),
        ),
        Step(
          isActive: currentstep >= 3,
          title: const Icon(Icons.card_giftcard),
          content: Container(),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Track Order",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              shrinkWrap: true,
              primary: false,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    onTap: () {
                      // showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.vertical(
                      //       top: Radius.circular(25),
                      //     ),
                      //   ),
                      //   context: context,
                      //   builder: (context) => RemoveFromCart(),
                      // );
                    },
                    child: Container(
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
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: themewhitecolor,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: themegreycolor),
                              image:  DecorationImage(
                                image: NetworkImage(
                                  widget.images,
                                ),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                        radius: 6,
                                        backgroundColor: themeblackcolor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Color",
                                        style: TextStyle(
                                            color: themegreytextcolor,
                                            fontSize: 12),
                                      ),
                                      VerticalDivider(),
                                      Text(
                                        "Size = M",
                                        style: TextStyle(
                                            color: themegreytextcolor,
                                            fontSize: 12),
                                      ),
                                      VerticalDivider(),
                                      Text(
                                        "Qty = 1",
                                        style: TextStyle(
                                            color: themegreytextcolor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: themegreycolor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Text(
                                    "In Delivery",
                                    style: TextStyle(
                                        color: themeblackcolor, fontSize: 8),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.price,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(
                  primary: Palette.themecolor,
                ),
              ),
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                steps: getStep(),
                currentStep: currentstep,
                onStepContinue: () {
                  final isLastStep = currentstep == getStep().length - 1;
                  if (isLastStep) {
                    print('Completed');
                  } else {
                    setState(() {
                      currentstep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  currentstep == 0
                      ? null
                      : setState(() {
                          currentstep -= 1;
                        });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
