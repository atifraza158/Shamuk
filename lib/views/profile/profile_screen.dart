import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/other/info_screen.dart';
import 'package:multivendor/views/profile/edit_profile_screen.dart';
import 'package:multivendor/views/profile/profile_change_password_screen.dart';
import 'package:multivendor/views/profile/profile_help_center_tabview.dart';
import 'package:multivendor/views/profile/profile_notification_screen.dart';
import 'package:multivendor/views/profile/profile_payment_screen.dart';
import 'package:multivendor/views/profile/profile_privacypolicy_screen.dart';
import 'package:multivendor/views/profile/return_policy_screen.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'terms_and_conditions_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  checkType_func() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? full_name = prefs.getString('full_name');

    setState(() {
      fullName = full_name.toString();
    });
  }

  @override
  void initState() {
    checkType_func();
    super.initState();
  }

  String fullName = '';

  @override
  Widget build(BuildContext context) {
    final userPro = Provider.of<auth_pro>(context);
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themewhitecolor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Palette.themecolor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: themegreytextcolor,
                  child: CircleAvatar(
                    radius: 55,
                    child: Icon(
                      Icons.person,
                      color: themeredcolor,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                userPro.getFullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                userPro.getEmail,
                style: const TextStyle(
                  color: themegreytextcolor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomSimpleRoundedButton(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const EditProfileScreen(),
                  );
                },
                buttoncolor: Palette.themecolor,
                height: 50,
                width: MediaQuery.of(context).size.width / 100 * 45,
                borderRadius: BorderRadius.circular(30),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //change password
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const ChangePasswordScreen(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.lock,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Change Password",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const ProfileNotificationScreen(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.notifications,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const ProfilePrivacyPolicy(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.privacy_tip,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const ReturnPrivacyPolicy(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.policy,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Return Policy",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const TermsAndCondtionScreen(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.description_sharp,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Terms & Condition",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    ProfileHelpCenterTabview(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.help_outline,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Help Center",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  RouteNavigator.route(
                    context,
                    InfoScreen(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.info,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Shamuk Info",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    context: context,
                    builder: (context) => const Logout(),
                  );
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.logout,
                  color: themedarkgreycolor,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themewhitecolor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  bool value = true;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: SizedBox(
        height: 220,
        child: Scaffold(
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomRoundedButton(
                buttonText: "Cancel",
                onTap: () {
                  Navigator.pop(context);
                },
                buttoncolor: themegreycolor,
                buttontextcolor: themeblackcolor,
                height: kMinInteractiveDimension,
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              CustomRoundedButton(
                buttoncolor: Palette.themecolor,
                buttontextcolor: themewhitecolor,
                buttonText: "Yes, Logout",
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  //removing stored things
                  prefs.remove('userCode');
                  prefs.remove('full_name');
                  prefs.remove('email');
                  prefs.remove('user_id');
                  prefs.remove('phone');
                  prefs.remove('country_id');
                  prefs.remove('state_id');
                  prefs.remove('city_id');
                  prefs.remove('address');

                  context.replaceNamed('splash');

                  // RouteNavigator.pushandremoveroute(
                  //     context, const LoginScreen());
                },
                height: kMinInteractiveDimension,
                width: MediaQuery.of(context).size.width * 0.45,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(
                    height: 50,
                  ),
                ),
                const Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
