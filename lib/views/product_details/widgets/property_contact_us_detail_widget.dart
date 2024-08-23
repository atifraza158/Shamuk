import 'package:flutter/material.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';

contactUsDetailWidget(properties_pro modelValue) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      //Agency

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            height: 50,
            decoration: BoxDecoration(
              color: themeredcolor,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/images/owner.png"),
          ),
          SizedBox(width: 10),
          Text(
            "Agency Details",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      SizedBox(height: 10),

      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Agency",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              modelValue.dPropertyShopName,
              style: TextStyle(
                // color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 5),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Email Address",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              modelValue.dPropertyBusinessEmail,
              style: TextStyle(
                // color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 5),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Phone No.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              modelValue.dPropertyPhoneNumber,
              style: TextStyle(
                // color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}








































// import 'package:flutter/material.dart';
// import 'package:multivendor/provider/properties_pro.dart';
// import 'package:multivendor/theme/colors.dart';

// contactUsDetailWidget(properties_pro modelValue){

//   return  PhysicalModel(
//                               color: themewhitecolor,
//                               elevation: 2,
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(5),
//                                 bottomRight: Radius.circular(5),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                   children: [
//                                     //Agency
//                                     PhysicalModel(
//                                       color: const Color.fromARGB(
//                                           255, 243, 243, 243),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(6.0),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 "Agency",
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 modelValue.dPropertyShopName,
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),

//                                     //Email
//                                     Padding(
//                                       padding: const EdgeInsets.all(6.0),
//                                       child: Row(
//                                         children: [
//                                           const Expanded(
//                                             child: Text(
//                                               "Email",
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               modelValue.dPropertyBusinessEmail,
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),

//                                     PhysicalModel(
//                                       color: const Color.fromARGB(
//                                           255, 243, 243, 243),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(6.0),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 "Phone",
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 modelValue.dPropertyPhoneNumber,
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
                         
// }