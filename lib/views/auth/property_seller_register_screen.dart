import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_drop_down.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/custom_text_field.dart';
import 'package:multivendor/widgets/outlined_box.dart';

class ActiveDot extends StatelessWidget {
  final int activeIndex;
  const ActiveDot({
    Key? key,
    required this.activeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Palette.themecolor,
          child: Text(
            activeIndex.toString(),
            style: const TextStyle(
                color: themewhitecolor, fontWeight: FontWeight.bold),
          ),
        ),
        activeIndex == 4
            ? const SizedBox()
            : SizedBox(
                width: size.width / 100 * 12,
                child: const Divider(
                  color: Palette.themecolor,
                  thickness: 4,
                ),
              ),
      ],
    );
  }
}

class InactiveDot extends StatelessWidget {
  final int inActiveIndex;
  const InactiveDot({
    Key? key,
    required this.inActiveIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.3),
          child: Text(
            inActiveIndex.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inActiveIndex == 4
            ? const SizedBox()
            : SizedBox(
                width: size.width / 100 * 12,
                child: Divider(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 4,
                ),
              ),
      ],
    );
  }
}

class PropertySellerRegisterScreen extends StatefulWidget {
  const PropertySellerRegisterScreen({super.key});

  @override
  State<PropertySellerRegisterScreen> createState() =>
      _PropertySellerRegisterScreenState();
}

class _PropertySellerRegisterScreenState
    extends State<PropertySellerRegisterScreen> {
  File? shopBanner;
  Future shopBannerImage() async {
    try {
      final shopBanner =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (shopBanner == null) return;
      final pickImagefromgallery = File(shopBanner.path);
      setState(() => this.shopBanner = pickImagefromgallery);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  File? shopLogo;
  Future shopLogoImage() async {
    try {
      final shopLogo =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (shopLogo == null) return;
      final pickImagefromgallery = File(shopLogo.path);
      setState(() => this.shopLogo = pickImagefromgallery);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  File? cnicImageFront;
  Future cnicFrontImage() async {
    try {
      final cnicImageFront =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (cnicImageFront == null) return;
      final pickImagefromgallery = File(cnicImageFront.path);
      setState(() => this.cnicImageFront = pickImagefromgallery);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  File? cnicImageBack;
  Future cnicBackImage() async {
    try {
      final cnicImageBack =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (cnicImageBack == null) return;
      final pickImagefromgallery = File(cnicImageBack.path);
      setState(() => this.cnicImageBack = pickImagefromgallery);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  int pageIndex = 0;
  int countryValue = 0;
  int stateValue = 0;
  int cityValue = 0;
  int bankValue = 0;
  int accountTypeValue = 0;
  int categoryValue = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themewhitecolor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (idx) {
              return pageIndex >= idx
                  ? ActiveDot(
                      activeIndex: (idx + 1),
                    )
                  : InactiveDot(
                      inActiveIndex: (idx + 1),
                    );
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            // Text.rich(
            //   TextSpan(
            //     text: "Already Registered? ",
            //     style: const TextStyle(
            //       color: themegreytextcolor,
            //       fontSize: 15,
            //     ),
            //     children: [
            //       TextSpan(
            //         recognizer: TapGestureRecognizer()
            //           ..onTap = () => Go.route(
            //                 context,
            //                 const SellerLoginScreen(),
            //               ),
            //         text: "Login",
            //         style: const TextStyle(
            //           color: Palette.themecolor,
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSimpleRoundedButton(
                  height: 50,
                  width: 150,
                  buttoncolor: Palette.themecolor,
                  borderRadius: BorderRadius.circular(12),
                  child: const Center(
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (pageIndex == 3) {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 2) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 1) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 0) {
                      Navigator.pop(context);
                    }
                  },
                ),
                CustomSimpleRoundedButton(
                  height: 50,
                  width: 150,
                  buttoncolor: Palette.themecolor,
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Text(
                      pageIndex == 3 ? 'Finish' : 'Next',
                      style: const TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (pageIndex == 0) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 1) {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 2) {
                      _pageController.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else if (pageIndex == 3) {
                      _pageController.animateToPage(
                        4,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                      // Go.route(
                      //   context,
                      //   SellerBottomNavBar(currentIndex: 0),
                      // );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                pageIndex = page;
              });
            },
            children: [
              personal(),
              bank(),
              shop(size),
              cnic(size),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         CustomButton(
          //           width: 150,
          //           borderRadius: BorderRadius.circular(30),
          //           child: const Center(
          //             child: Text(
          //               'Back',
          //               style: TextStyle(
          //                 color: themewhitecolor,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //           onTap: () {
          //             if (pageIndex == 0) {
          //               _pageController.jumpToPage(1);
          //             } else if (pageIndex == 1) {
          //               _pageController.jumpToPage(2);
          //             } else if (pageIndex == 2) {
          //               _pageController.jumpToPage(3);
          //             } else if (pageIndex == 3) {
          //               _pageController.jumpToPage(4);
          //             } else if (pageIndex == 4) {
          //               _pageController.jumpToPage(5);
          //             } else if (pageIndex == 5) {
          //               _pageController.jumpToPage(6);
          //               // Nav.replace(
          //               //   context,
          //               //   AppRouter.bottomNavigationBar,
          //               // );
          //             }
          //           },
          //         ),
          //         CustomButton(
          //           width: 150,
          //           borderRadius: BorderRadius.circular(30),
          //           child: const Center(
          //             child: Text(
          //               'Next',
          //               style: TextStyle(
          //                 color: themewhitecolor,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //           onTap: () {
          //             if (pageIndex == 0) {
          //               _pageController.jumpToPage(1);
          //             } else if (pageIndex == 1) {
          //               _pageController.jumpToPage(2);
          //             } else if (pageIndex == 2) {
          //               _pageController.jumpToPage(3);
          //             } else if (pageIndex == 3) {
          //               _pageController.jumpToPage(4);
          //             } else if (pageIndex == 4) {
          //               _pageController.jumpToPage(5);
          //             } else if (pageIndex == 5) {
          //               _pageController.jumpToPage(6);
          //               // Nav.replace(
          //               //   context,
          //               //   AppRouter.bottomNavigationBar,
          //               // );
          //             }
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget personal() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "First Name",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Last Name",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Email",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.number,
                hintText: "Phone",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              CustomDropDown(
                hint: 'Country',
                errorText: '',
                value: countryValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('Country 1'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('Country 2'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('Country 3'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomDropDown(
                hint: 'State',
                errorText: '',
                value: stateValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('State 1'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('State 2'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('State 3'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomDropDown(
                hint: 'City',
                errorText: '',
                value: cityValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('City 1'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('City 2'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('City 3'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Address",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "National Identification Number",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Password",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Confirm Password",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bank() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bank",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Text(
                'Select Bank',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              CustomDropDown(
                hint: 'Bank',
                errorText: '',
                value: bankValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('MCB'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('State Bank'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('Habib Bank'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Account IBAN Number (24 Characters)",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Account Title",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shop(size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shop Details",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              CustomDropDown(
                hint: 'Account type',
                errorText: '',
                value: accountTypeValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('Type 1'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('Type 2'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('Type 3'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    accountTypeValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomDropDown(
                hint: 'Select Category',
                errorText: '',
                value: categoryValue,
                items: [
                  const DropdownMenuItem(
                    value: 0,
                    child: Text('Category 1'),
                  ),
                  const DropdownMenuItem(
                    value: 1,
                    child: Text('Category 2'),
                  ),
                  const DropdownMenuItem(
                    value: 2,
                    child: Text('Category 3'),
                  ),
                ].cast<DropdownMenuItem<int>>(),
                onChanged: (value) {
                  setState(() {
                    categoryValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Shop Name",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Bussiness Email",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.number,
                hintText: "Bussiness Phone",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.text,
                hintText: "Bussiness Address",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.number,
                hintText: "National Tax Number",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                textInputType: TextInputType.number,
                hintText: "Sales Tax Number",
                filled: true,
                fillColor: themetextfieldcolor,
                isOutlinedInputBorder: true,
                focusedBorderColor: Palette.themecolor,
                borderWidth: 1.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Shop Banner",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        OutlinedBox(
                          onTap: () async {
                            await shopBannerImage();
                          },
                          height: 150,
                          width: size.width,
                          child: shopBanner != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    shopBanner!,
                                    height: 150,
                                    width: size.width,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Shop Logo",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        OutlinedBox(
                          onTap: () async {
                            await shopLogoImage();
                          },
                          height: 150,
                          width: size.width,
                          child: shopLogo != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    shopLogo!,
                                    height: 150,
                                    width: size.width,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cnic(size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CNIC",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Text(
                "CNIC Front",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              OutlinedBox(
                onTap: () async {
                  await cnicFrontImage();
                },
                height: 250,
                width: size.width,
                child: cnicImageFront != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          cnicImageFront!,
                          height: 240,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.add,
                        size: 40,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "CNIC Back",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              OutlinedBox(
                onTap: () async {
                  await cnicBackImage();
                },
                height: 250,
                width: size.width,
                child: cnicImageBack != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          cnicImageBack!,
                          height: 240,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.add,
                        size: 40,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
