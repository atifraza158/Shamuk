import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/order_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/orders/tabs/completed_tab.dart';
import 'package:multivendor/views/orders/tabs/pending_tab.dart';
import 'package:multivendor/views/orders/tabs/processing_tab.dart';
import 'package:provider/provider.dart';

class MyOrdersTabview extends StatefulWidget {
  const MyOrdersTabview({Key? key}) : super(key: key);

  @override
  _MyOrdersTabviewState createState() => _MyOrdersTabviewState();
}

class _MyOrdersTabviewState extends State<MyOrdersTabview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    if (Provider.of<auth_pro>(context, listen: false).userId != null) {
      final orderProvider = Provider.of<order_pro>(context, listen: false);
      orderProvider.getOrdersListFunc(context);
    }
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: themewhitecolor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "My Orders",
                      style: TextStyle(
                        color: Palette.themecolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    controller: _tabController,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Palette.themecolor,
                          width: 3.0,
                        ),
                      ),
                    ),
                    dragStartBehavior: DragStartBehavior.start,
                    labelColor: Palette.themecolor,
                    unselectedLabelColor: themegreytextcolor,
                    labelStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        text: 'Pending',
                      ),
                      Tab(
                        text: 'Processing',
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [PendingTab(), ProcessingTab(), CompletedTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
