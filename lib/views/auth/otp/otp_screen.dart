// // ignore_for_file: non_constant_identifier_names

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:http/http.dart' as http;
// import 'package:multivendor/apis/apis_list.dart';
// import 'package:multivendor/provider/auth_pro.dart';
// import 'package:multivendor/theme/colors.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OtpScreen extends StatefulWidget {
//   final String Otp;
//   final int value;

//   const OtpScreen({
//     Key? key,
//     required this.Otp,
//     required this.value,
//   }) : super(key: key);

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   @override
//   void initState() {
//     super.initState();
//     if (widget.value == 1) {
//       log("init-state user login but not verified resent_request() is called.");

//       user_resend_request();
//     } else if (widget.value == 4) {
//       log("init-state vendor login but not verified vendor_resend_request() is called.");

//       // vendor_resend_request();
//     } else {
//       log("else*****************");
//     }
//   }

//   // vendor_resend_request() async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   final String? userCode = prefs.getString('vendeorSignupCode');
//   //   log("$userCode");

//   //   final response = await http.get(
//   //     Uri.parse(vendor_resend_api + "/$userCode"),
//   //   );
//   //   Map<String, dynamic> resposne = jsonDecode(response.body);
//   //   if (response.statusCode == 200) {
//   //     setState(() {
//   //       Optresend = resposne['otp'].toString();
//   //       log("$Optresend");
//   //     });
//   //   } else {
//   //     ScaffoldMessenger.of(context)
//   //         .showSnackBar(SnackBar(content: Text("Please Try again")));
//   //   }
//   // }

//   user_resend_request() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String? userCode = prefs.getString('userCode');
//       log("$userCode");
//       Map data = {
//         'code': userCode,
//       };
//       final response = await http.post(Uri.parse(acc_resend_otp_api), body: data);
//       Map<String, dynamic> resposne = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           Optresend = resposne['otp'].toString();
//           log("OTP: $Optresend");
//           resendIsLoading = false;
//         });
//       } else {
//         showCustomToast("Please Try again.", themeredcolor, context);
//       }
//     } catch (e) {
//       showCustomToast("Catch Error: $e", themeredcolor, context);
//     }
//     resendIsLoading = false;
//   }

//   String Optresend = "";

//   bool resendIsLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.themecolor,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: themeblackcolor),
//         backgroundColor: Palette.themecolor,
//         elevation: 0,
//         title: Text(
//           "Email Verification",
//           style: TextStyle(color: themewhitecolor, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We Have Send Otp On Your Given Email",
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: themeblackcolor,
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Enter OTP Code",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Palette.themecolor),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: OtpTextField(
//                         fieldWidth: 40,
//                         numberOfFields: 6,
//                         keyboardType: TextInputType.number,
//                         autoFocus: true,
//                         borderWidth: 4.0,

//                         borderColor: Palette.themecolor,
//                         borderRadius: BorderRadius.circular(15),
//                         focusedBorderColor: Palette.themecolor,
//                         showFieldAsBox: true,
//                         onCodeChanged: (String code) {
//                           //handle validation or checks here
//                         },
//                         //runs when every textfield is filled
//                         onSubmit: (String verificationCode) async {
//                           if (Optresend == "") {
//                             if (verificationCode == widget.Otp) {
//                               if (widget.value == 0) {
//                                 log("User Otp Verified");
//                                 final ProviderPost = Provider.of<auth_pro>(
//                                     context,
//                                     listen: false);
//                                 ProviderPost.user_verify(context);
//                               } else if (widget.value == 3) {
//                                 log("Vendor Otp Verified");
//                                 // final ProviderPost = Provider.of<vendor_pro>(
//                                 //     context,
//                                 //     listen: false);
//                                 // ProviderPost.vendor_verify(context);
//                               } else if (widget.value == 2) {
//                                 log("User from Password Change Otp Verified");
//                                 RouteNavigator.route(
//                                     context, NewPasswordScreen());
//                                 // final ProviderPost = Provider.of<auth_pro>(
//                                 //     context,
//                                 //     listen: false);
//                                 // ProviderPost.user_password_verify(
//                                 //     verificationCode, context);
//                               } else {
//                                 log("opt matched, but else condition run line 202");
//                                 // RouteNavigator.replacementroute(
//                                 //     context, LoginDetailsScreen());
//                               }
//                             } else {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: Text("Oops"),
//                                       content: Text(
//                                           'Wrong Otp Code $verificationCode'),
//                                     );
//                                   });
//                             }
//                           } else if (verificationCode == Optresend) {
//                             if (widget.value == 1) {
//                               log("User Resend Otp Verified");
//                               final ProviderPost =
//                                   Provider.of<auth_pro>(context, listen: false);
//                               ProviderPost.user_verify(context);
//                             } else if (widget.value == 4) {
//                               log("Vendor Resend Otp Verified");
//                               // final ProviderPost = Provider.of<vendor_pro>(
//                               //     context,
//                               //     listen: false);
//                               // ProviderPost.vendor_verify(context);
//                             } else {
//                               log("opt matched, but else condition run");
//                               // RouteNavigator.replacementroute(
//                               //     context, LoginDetailsScreen());
//                             }
//                           } else {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Text("Oops"),
//                                     content: Text(
//                                         'Wrong resend Otp Code $verificationCode'),
//                                   );
//                                 });
//                           }
//                         }, // end onSubmit
//                       ),
//                     ),
                   
                   
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           resendIsLoading = true;
//                         });
//                         if (widget.value == 1) {
//                           log("user user_resend_request() is called.");

//                           user_resend_request();
//                         } else if (widget.value == 4) {
//                           log("vendor vendor_resend_request() is called.");

//                           // vendor_resend_request();
//                         }
//                       },
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Container(
//                           width: width / 100 * 90,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Palette.themecolor,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: resendIsLoading
//                               ? const Center(
//                                   child: CircularProgressIndicator(
//                                     color: themewhitecolor,
//                                   ),
//                                 )
//                               : const Text(
//                                   "Resend Verification",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: themewhitecolor,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
