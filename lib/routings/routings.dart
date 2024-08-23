import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multivendor/main.dart';
import 'package:multivendor/navigation/shamuk_bottom_navbar.dart';
import 'package:multivendor/onboarding/onboardingscreen.dart';
import 'package:multivendor/splash/splash_screen.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/auth/sign_up_screen.dart';
import 'package:multivendor/views/other/info_screen.dart';

class AppRoute {
  GoRouter router = GoRouter(
    initialLocation: isViewed != 0 ? '/onBoarding' : '/splash',
    routes: [
      GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
            // return InfoScreen();
          }),
      GoRoute(
          name: 'welcomeScreen',
          path: '/welcomeScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeScreen();
          }),
      GoRoute(
          name: 'onBoarding',
          path: '/onBoarding',
          builder: (BuildContext context, GoRouterState state) {
            return const OnboardingScreen();
          }),
      GoRoute(
          name: 'bottomNavBar',
          path: '/bottomNavBar',
          builder: (BuildContext context, GoRouterState state) {
            return ShamukBottomNavBar(
                currentIndex:
                    int.parse(state.queryParams['selectedTab'].toString()));
            // return NavBar(
            //     selectedTab:
            //         int.parse(state.queryParams['selectedTab'].toString()));
          }),
      GoRoute(
          name: 'loginScreen',
          path: '/loginScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          }),
      GoRoute(
          name: 'signupScreen',
          path: '/signupScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          }),
    ],
  );
}
