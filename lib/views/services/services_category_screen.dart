import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/dummy_models/dummy_models.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/home/home_screen.dart';
import 'package:multivendor/views/product_category/product_category_screen.dart';
import 'package:multivendor/views/services/modal/services_filters_bottem_sheet.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/custom_text_button.dart';
import 'package:shimmer/shimmer.dart';

class ServicesCategoryScreen extends StatefulWidget {
  const ServicesCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ServicesCategoryScreen> createState() => _ServicesCategoryScreenState();
}

class _ServicesCategoryScreenState extends State<ServicesCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: themedarkgreycolor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Design & Renovation",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: servicesmodel.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        RouteNavigator.route(
                          context,
                          ProductCategoryScreen(
                            title: servicesmodel[index].title,
                            productCategory: 1,
                            categoryId: "",
                            serviceId: index + 1,
                          ),
                        );
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: themegreytextcolor,
                          image: (index == (servicesmodel.length - 1))
                              ? null
                              : DecorationImage(
                                  image: AssetImage(servicesmodel[index].image),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeblackcolor.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              servicesmodel[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
