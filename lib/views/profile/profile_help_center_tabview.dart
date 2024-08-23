import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/profile/contactus_screen.dart';
import 'package:multivendor/views/profile/faq_screen.dart';

class ProfileHelpCenterTabview extends StatefulWidget {
  @override
  _ProfileHelpCenterTabviewState createState() =>
      _ProfileHelpCenterTabviewState();
}

class _ProfileHelpCenterTabviewState extends State<ProfileHelpCenterTabview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Help Center",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Palette.themecolor,
                      width: 4.0,
                    ),
                  ),
                ),
                dragStartBehavior: DragStartBehavior.start,
                labelColor: Palette.themecolor,
                unselectedLabelColor: themegreytextcolor,
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: 'FAQ',
                  ),
                  Tab(
                    text: 'Contact Us',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FaqScreen(),
                  ContactusScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
