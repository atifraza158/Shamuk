// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProfileSecurityScreen extends StatefulWidget {
//   const ProfileSecurityScreen({Key? key}) : super(key: key);

//   @override
//   State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
// }

// class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
//   bool value = true;
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           "Security",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         children: [
//           ListView.separated(
//             padding: const EdgeInsets.only(
//               left: 20,
//               top: 20,
//               right: 6,
//             ),
//             primary: false,
//             shrinkWrap: true,
//             itemCount: profilesecuritymodel.length,
//             itemBuilder: (context, index) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     profilesecuritymodel[index].title,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Transform.scale(
//                     scale: 0.65,
//                     child: CupertinoSwitch(
//                       activeColor: themeChange.darkTheme == true
//                           ? themedarkgreycolor
//                           : themeChange.darkTheme == false
//                               ? themeblackcolor
//                               : null,
//                       value: value,
//                       onChanged: (value) => setState(() => this.value = value),
//                     ),
//                   ),
//                 ],
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return const SizedBox(
//                 height: 20,
//               );
//             },
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           CustomSimpleRoundedButton(
//             buttonText: "Change Pin",
//             buttoncolor: themegreycolor,
//             buttontextcolor: themeblackcolor,
//             onTap: () {},
//             height: kMinInteractiveDimension,
//             width: MediaQuery.of(context).size.width * 0.80,
//           ),
//           CustomSimpleRoundedButton(
//             buttonText: "Change Password",
//             buttoncolor: themegreycolor,
//             buttontextcolor: themeblackcolor,
//             onTap: () {},
//             height: kMinInteractiveDimension,
//             width: MediaQuery.of(context).size.width * 0.80,
//           ),
//         ],
//       ),
//     );
//   }
// }
