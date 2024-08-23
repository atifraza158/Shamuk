import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/cart/my_cart_new.dart';
import 'package:multivendor/views/home/home_screen.dart';
import 'package:multivendor/views/orders/my_orders_tabview.dart';
import 'package:multivendor/views/profile/profile_screen.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShamukBottomNavBar extends StatefulWidget {
  int currentIndex;
  ShamukBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<ShamukBottomNavBar> createState() => _ShamukBottomNavBarState();
}

class _ShamukBottomNavBarState extends State<ShamukBottomNavBar> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.currentIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    if (page == 1 || page == 2 || page == 3) {
      if (Provider.of<auth_pro>(context, listen: false).userId != null) {
        pageController.jumpToPage(page);
      } else {
        RouteNavigator.route(
          context,
          const LoginScreen(),
        );
      }
    } else {
      pageController.jumpToPage(page);
    }
  }

  void onPageChanged(int page) {
    setState(() {
      widget.currentIndex = page;
    });
  }

  List<Widget> navBarItems = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeScreen(),
          MyCartNew(),
          MyOrdersTabview(),
          ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: themewhitecolor,

          // boxShadow: [
          //   BoxShadow(
          //     color: themewhitecolor,
          //     blurRadius: 8,
          //     spreadRadius: 8,
          //     offset: Offset(0, -2),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => CustomIconButton(
              onTap: () {
                navigationTapped(index);
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: themewhitecolor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: themegreycolor,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      index == 0
                          ? "assets/images/svg/home-sp.svg"
                          : index == 1
                              ? "assets/images/svg/cart-sp.svg"
                              : index == 2
                                  ? "assets/images/svg/orders-sp.svg"
                                  : "assets/images/svg/profile-sp.svg",
                      color: widget.currentIndex == index
                          ? Palette.themecolor
                          : themeblackcolor,
                      height: 20,
                    ),
                    Text(
                      index == 0
                          ? "Home"
                          : index == 1
                              ? "Cart"
                              : index == 2
                                  ? "Orders"
                                  : "Profile",
                      style: TextStyle(
                        color: widget.currentIndex == index
                            ? Palette.themecolor
                            : themeblackcolor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
