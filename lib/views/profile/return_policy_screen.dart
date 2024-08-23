import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class ReturnPrivacyPolicy extends StatefulWidget {
  const ReturnPrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<ReturnPrivacyPolicy> createState() => _ReturnPrivacyPolicyState();
}

class _ReturnPrivacyPolicyState extends State<ReturnPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Return Policy",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "How to Return an Item",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                """To initiate a return, Please Contact Supplier Within 3 days of Delivery .
 Note: Shamuk is not in any way involved in such transactions. As a result, and as discussed in more detail in these Terms, you hereby acknowledge and agree that SHAMUK is not a party to such transactions, has no control over any element of such transactions, and shall have no liability to any party in connection with such transactions. You use the Service and the Website at your own risk.

Standard Return Requirements . 

All returns must be in unused condition and include all original product inserts and accessories.
Items must be returned in original packaging 
Returns must also be in disassembled condition, if the item(s) were originally delivered disassembled.

There are a few items that may not be returned:

Items marked "non-returnable" on the product page or during the checkout process (such as custom-made items);

Returns for Damaged/Defective, Incorrect, or Missing Items

If you receive a product in damaged condition, please initiate the return process promptly. You may request a full refund, replacement, or replacement parts.  For damages, our return policy requires you to initiate your return request within 3 days of delivery for standard delivery items although Shamuk will not be responsible for such transaction , as we are just providing the access to the vendors.

Please note , Shamuk is not responsible for packages that may have gone missing post-delivery. This includes freight items that may have been delivered with a contactless service where no signature or appointment is required. We highly recommend monitoring your tracking information and reporting any issues with a delivery as soon as possible. """,
                style: TextStyle(
                  color: themegreytextcolor,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
