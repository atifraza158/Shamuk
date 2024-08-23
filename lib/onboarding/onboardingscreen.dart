import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  _storeOnBoarding() async {
    int isViewed = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('onboarding', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    _storeOnBoarding();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: const [
                CreatePage(
                  image: 'assets/images/svg/onboard-1.svg',
                  title: "One",
                  subtitle: "We provide High Quality products just for you!",
                  color: Palette.themecolor,
                ),
                CreatePage(
                  image: 'assets/images/svg/onboard-2.svg',
                  title: "Two",
                  subtitle: "Your satisfaction is our number one priority",
                  color: Palette.themecolor,
                ),
                CreatePage(
                  image: 'assets/images/svg/onboard-3.svg',
                  title: "Three",
                  subtitle:
                      "Let's fulfill your daily needs with ecommerce right now!",
                  color: Palette.themecolor,
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: _buildIndicator(),
                  ),
                  CustomIconButton(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 0) {
                          _pageController.jumpToPage(1);
                        } else if (currentIndex == 1) {
                          _pageController.jumpToPage(2);
                        } else if (currentIndex == 2) {
                          _storeOnBoarding();

                          // context.pushNamed("loginScreen");
                          context.replaceNamed('bottomNavBar', queryParams: {
                            'selectedTab': '0',
                          });
                        }
                      });
                    },
                    child: currentIndex == 2
                        ? AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                              children: const [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: themewhitecolor,
                                ),
                              ],
                            ),
                          )
                        : AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: currentIndex == 0
                                  ? Palette.themecolor
                                  : currentIndex == 1
                                      ? Palette.themecolor
                                      : Palette.themecolor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: themewhitecolor,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Extra Widgets

  //Create the indicator decorations widget
  Widget _activeindicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Palette.themecolor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _inactiveindicator(bool isInActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isInActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: themegreycolor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_activeindicator(true));
      } else {
        indicators.add(_inactiveindicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final String subtitle;
  const CreatePage(
      {Key? key,
      required this.image,
      required this.title,
      required this.color,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height / 100 * 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                fit: BoxFit.cover,
                height: 300,
                width: size.width / 100 * 80,
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.replaceNamed(
        'onBoarding',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: themewhitecolor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/png/shamuk-white.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Lottie.asset(
                    'assets/images/animated/welcome-loader.json',
                    height: 250,
                    width: 250,
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
