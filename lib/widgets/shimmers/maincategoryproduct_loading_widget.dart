import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class MainCategoriesProductLoadingWidget extends StatelessWidget {
  const MainCategoriesProductLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
        baseColor: themegreycolor,
        highlightColor: themegreycolor,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(5, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                    width: size.width ,
                    height: size.height / 100 * 10,
                    decoration: BoxDecoration(
                      color: themegreycolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              );
            }),
          ),
        ));
  }
}
