import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/cart/my_cart_new.dart';
import 'package:multivendor/views/home/home_screen.dart';
import 'package:multivendor/views/my_ewallet/my_ewallet_screen.dart';
import 'package:multivendor/views/orders/my_orders_tabview.dart';
import 'package:multivendor/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBar extends StatefulWidget {
  int selectedTab = 0;
  NavBar({super.key, required this.selectedTab});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // var widget.selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SalomonBottomBar(
          currentIndex: widget.selectedTab,
          selectedColorOpacity: 1,
          onTap: (position) {
            print("position : $position");
            if (position == 1 || position == 2 || position == 3) {
              if (Provider.of<auth_pro>(context, listen: false).userId !=
                  null) {
                setState(() {
                  widget.selectedTab = position;
                });
              } else {
                RouteNavigator.route(
                  context,
                  const LoginScreen(),
                );
              }
            }else{
              setState(() {
                  widget.selectedTab = position;
                });
            }
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                widget.selectedTab == 0
                    ? "assets/images/svg/home-sp.svg"
                    : "assets/images/svg/home-sp-outlined.svg",
                color:
                    widget.selectedTab == 0 ? themewhitecolor : themeblackcolor,
                height: 25,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
              selectedColor: Palette.themecolor,
              unselectedColor: themeblackcolor,
            ),

            /// Cart
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                widget.selectedTab == 1
                    ? "assets/images/svg/cart-sp.svg"
                    : "assets/images/svg/cart-sp-outlined.svg",
                color:
                    widget.selectedTab == 1 ? themewhitecolor : themeblackcolor,
                height: 25,
              ),
              title: const Text(
                "Cart",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
              selectedColor: Palette.themecolor,
            ),

            /// My Orders
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                widget.selectedTab == 2
                    ? "assets/images/svg/orders-sp.svg"
                    : "assets/images/svg/orders-sp-outlined.svg",
                color:
                    widget.selectedTab == 2 ? themewhitecolor : themeblackcolor,
                height: 25,
              ),
              title: const Text(
                "Orders",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
              selectedColor: Palette.themecolor,
            ),

            // /// Profile
            // SalomonBottomBarItem(
            //   icon: SvgPicture.asset(
            //     widget.selectedTab == 3
            //         ? "assets/images/svg/wallet-sp.svg"
            //         : "assets/images/svg/wallet-sp-outlined.svg",
            //     color: widget.selectedTab == 3 ? themewhitecolor : themeblackcolor,
            //     height: 25,
            //   ),
            //   title: const Text(
            //     "Wallet",
            //     style: TextStyle(
            //       color: themewhitecolor,
            //     ),
            //   ),
            //   selectedColor: Palette.themecolor,
            // ),

            /// Profile
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                widget.selectedTab == 3
                    ? "assets/images/svg/profile-sp.svg"
                    : "assets/images/svg/profile-sp-outlined.svg",
                color:
                    widget.selectedTab == 3 ? themewhitecolor : themeblackcolor,
                height: 25,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
              selectedColor: Palette.themecolor,
            ),
          ],
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: widget.selectedTab,
      children: const [
        HomeScreen(),

        MyCartNew(),
        MyOrdersTabview(),
        // MyEwalletScreen(),
        ProfileScreen(),
      ],
    );
  }
}
