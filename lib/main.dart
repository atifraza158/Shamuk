import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/cart_pro.dart';
import 'package:multivendor/provider/category_pro.dart';
import 'package:multivendor/provider/order_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/provider/wanted_pro.dart';
import 'package:multivendor/routings/routings.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getInt('onboarding');
  await Firebase.initializeApp();
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("message.notification!.title.toString()");
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //auth pro
        ChangeNotifierProvider<auth_pro>(create: (_) => auth_pro()),
        ChangeNotifierProvider<category_pro>(create: (_) => category_pro()),
        ChangeNotifierProvider<products_pro>(create: (_) => products_pro()),
        ChangeNotifierProvider<cart_pro>(create: (_) => cart_pro()),
        //properties
        ChangeNotifierProvider<properties_pro>(create: (_) => properties_pro()),
        //servies
        ChangeNotifierProvider<services_pro>(create: (_) => services_pro()),
        //order
        ChangeNotifierProvider<order_pro>(create: (_) => order_pro()),
        //wanted
        ChangeNotifierProvider<wanted_pro>(create: (_) => wanted_pro()),
      ],
      child: MaterialApp.router(
        title: 'Shamuk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.themecolor,
          fontFamily: "FiraSans",
        ),
        // home: isViewed != 0 ? const WelcomeScreen() : const SplashScreen(),
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1900,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1900, name: DESKTOP),
          ],
        ),
        // routerConfig: AppRoute().router,
        routerDelegate: AppRoute().router.routerDelegate,
        routeInformationParser: AppRoute().router.routeInformationParser,
        routeInformationProvider: AppRoute().router.routeInformationProvider,
      ),
    );
  }
}
