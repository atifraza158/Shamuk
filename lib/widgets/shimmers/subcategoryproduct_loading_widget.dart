import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesProductLoadingWidget extends StatelessWidget {
  const SubCategoriesProductLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
        baseColor: themegreycolor,
        highlightColor: themegreycolor,
        child: GridView.builder(
            padding: const EdgeInsets.all(20),
            primary: false,
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 320,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: Container(
                  width: size.width,
                  height: size.height / 100 * 10,
                  decoration: BoxDecoration(
                    color: themegreycolor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }));
  }
}
