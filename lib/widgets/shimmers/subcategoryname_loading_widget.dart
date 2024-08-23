import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesNameLoadingWidget extends StatelessWidget {
  const SubCategoriesNameLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
        baseColor: themegreycolor,
        highlightColor: themegreycolor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  width: size.width / 100 * 20,
                  height: size.height / 100 * 4,
                  decoration: BoxDecoration(
                    color: themegreycolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
