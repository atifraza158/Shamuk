import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/model/filter/property_filter_m.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:provider/provider.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: Palette.themecolor,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  const InactiveDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class FeedImageSlider extends StatefulWidget {
  // final List items;
  const FeedImageSlider({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeedImageSliderState createState() => _FeedImageSliderState();
}

class _FeedImageSliderState extends State<FeedImageSlider> {
  @override
  void initState() {
    final sliderCitiesProvider = Provider.of<auth_pro>(context, listen: false);
    sliderCitiesProvider.homeSliderCitiesFunc(context);
    super.initState();
  }

  int activeIndex = 0;

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<auth_pro>(builder: ((context, cityValue, child) {
      return cityValue.homeSliderIsLoading
          ? const Center(child: CircularProgressIndicator())
          : cityValue.homeSliderName.isEmpty
              ? const Center(child: Text("No Data"))
              : Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlay: true,
                        height: 230,
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        viewportFraction: 0.4,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setActiveDot(index);
                        },
                      ),
                      items: List.generate(
                        cityValue.homeSliderName.length,
                        (index) {
                          return InkWell(
                            onTap: () async {
                              // final cityInfo = await Provider.of<auth_pro>(
                              //         context,
                              //         listen: false)
                              //     .getCityInfo(cityValue.homeSliderCityId[index]
                              //         .toString());

                              final propertyPro = Provider.of<properties_pro>(
                                  context,
                                  listen: false);
                             
                              propertyPro.propertyFilter = PropertyFilterM(
                                city: cityValue.cityDataHome[index]['city'],
                                cityId: cityValue.cityDataHome[index]['city_id'],
                                countryId: cityValue.cityDataHome[index]['country_id'],
                                country: cityValue.cityDataHome[index]['country'],
                                state: cityValue.cityDataHome[index]['state'],
                                stateId: cityValue.cityDataHome[index]['state_id'],
                              );
                             
                              RouteNavigator.route(
                                context,
                                PropertiesListScreen(
                                  isShowAppBar: true,
                                  country: true,
                                ),
                              );
                            },
                            child: Container(
                              height: 200,
                              width: size.width / 100 * 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage((cityValue
                                              .homeSliderImage[index] !=
                                          null)
                                      ? homeSliderCardAPi +
                                          cityValue.homeSliderImage[index]
                                      : "https://cdn.dribbble.com/users/1284433/screenshots/7089095/media/28cb5727542e958337aec5be720fa4c3.png?resize=400x0"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: Container(
                              //   padding: const EdgeInsets.all(20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20),
                              //     gradient: LinearGradient(
                              //       colors: [
                              //         themeblackcolor.withOpacity(0.2),
                              //         themeblackcolor.withOpacity(0.4),
                              //         themeblackcolor.withOpacity(0.6),
                              //         themeblackcolor.withOpacity(0.9),
                              //       ],
                              //       begin: Alignment.topCenter,
                              //       end: Alignment.bottomCenter,
                              //     ),
                              //   ),
                              //   child: Stack(
                              //     alignment: AlignmentDirectional.center,
                              //     children: [
                              //       Text(
                              //         cityValue.homeSliderName[index],
                              //         style: const TextStyle(
                              //           fontSize: 22,
                              //           color: themewhitecolor,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -25,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cityValue.homeSliderImage.length,
                          (idx) {
                            return activeIndex == idx
                                ? const ActiveDot()
                                : const InactiveDot();
                          },
                        ),
                      ),
                    ),
                  ],
                );
    }));
  }
}

class FeedImageSliderModel {
  final String image;
  FeedImageSliderModel({
    required this.image,
  });
}

List<FeedImageSliderModel> imageslidercontent = [
  FeedImageSliderModel(
    image:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/ea/99/11/exterior.jpg?w=700&h=-1&s=1",
  ),
  FeedImageSliderModel(
    image:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/b2/2e/64/atlantis-the-palm.jpg?w=700&h=-1&s=1",
  ),
  FeedImageSliderModel(
    image:
        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/445419839.jpg?k=6278d7b2759917b85b4f9cb75210ad7861f64426986a76d077c2ce5dd3023529&o=&hp=1",
  ),
];
