import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
 

  final _key = GlobalKey<FormState>();

  final oldPasswordC = TextEditingController();
  final newPasswordC = TextEditingController();
  final cNewPasswordC = TextEditingController();

  
  //passwords variables
  bool isOldPasswordShow = false;
  bool isNewPasswordShow = false;
  bool isConfirmPasswordShow = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreycolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSimpleRoundedButton( 
            onTap: () {
              if (_key.currentState!.validate()) {
                final passwordProvider =
                    Provider.of<auth_pro>(context, listen: false);
                    passwordProvider.userChangePasswordfunc(oldPasswordC.text, newPasswordC.text, context);
               
              }
            },
            buttoncolor: Palette.themecolor,
            height: kMinInteractiveDimension,
            width: MediaQuery.of(context).size.width * 0.85,
            borderRadius: BorderRadius.circular(12),
            child: const Text(
              "Update",
              style: TextStyle(
                color: themewhitecolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Consumer<auth_pro>(builder: ((context, modelValue, child) {
              if (modelValue.userCurrentDataIsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
               

                return
                 Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Current Password",
                        style: TextStyle(
                         
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       TextFormField(
                                controller: oldPasswordC,
                                obscureText: !isOldPasswordShow,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: themewhitecolor,
                                    hintText: "Current Password",
                                    hintStyle: const TextStyle(fontSize: 15),
                                     errorStyle:const TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isOldPasswordShow = !isOldPasswordShow;
                                        });
                                      },
                                      child: isOldPasswordShow
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    )),
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                                  if (value == null || value.isEmpty) {
                                    return ("password is empty");
                                  } else if (value.length <8) {
                                    return ("Password Must be more than 8 characters");
                                  } else if (!regex.hasMatch(value)) {
                                    return ("Password should contain Upper, Lower, Digit and Special character ");
                                  }
                                  return null;
                                }),
                    
                      const SizedBox(
                        height: 20,
                      ),
                        const Divider(
                thickness: 1.5,
              ),
              const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "New Password",
                        style: TextStyle(
                         
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       TextFormField(
                                controller: newPasswordC,
                                obscureText: !isNewPasswordShow,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: themewhitecolor,
                                    hintText: "New Password",
                                    hintStyle: const TextStyle(fontSize: 15),
                                     errorStyle:const TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isNewPasswordShow = !isNewPasswordShow;
                                        });
                                      },
                                      child: isNewPasswordShow
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    )),
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                                  if (value == null || value.isEmpty) {
                                    return ("password is empty");
                                  } else if (value.length <8) {
                                    return ("Password Must be more than 8 characters");
                                  } else if (!regex.hasMatch(value)) {
                                    return ("Password should contain Upper, Lower, Digit and Special character ");
                                  }
                                  return null;
                                }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     TextFormField(
                                controller: cNewPasswordC,
                                obscureText: !isConfirmPasswordShow,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: themewhitecolor,
                                    hintText: "Confirm Password",
                                    hintStyle: const TextStyle(fontSize: 15),
                                    errorStyle:const TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isConfirmPasswordShow =
                                              !isConfirmPasswordShow;
                                        });
                                      },
                                      child: isConfirmPasswordShow
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "confirm password is empty";
                                  } else if (value != newPasswordC.text) {
                                    return "password dosent match";
                                  } else {
                                    return null;
                                  }
                                }),

                     

                   
                    ],
                  ),
                );
           
           
              }
            }))),
      ),
    );
  }
}
