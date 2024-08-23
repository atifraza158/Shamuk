import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/product_details/product_details_screen.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoryProductsScreen extends StatefulWidget {
  final String title;
  final String subCatergoryId;

  const SubCategoryProductsScreen({
    super.key,
    required this.title,
    required this.subCatergoryId,
  });

  @override
  State<SubCategoryProductsScreen> createState() =>
      _SubCategoryProductsScreenState();
}

class _SubCategoryProductsScreenState extends State<SubCategoryProductsScreen> {
  @override
  void initState() {
    final productProvider = Provider.of<products_pro>(context, listen: false);

    productProvider.getProducts(
        "", "1", widget.subCatergoryId, "", "", "", "", context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: themegreytextcolor,
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Row(
              children: [
                CustomIconButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: themewhitecolor,
                    child: Icon(
                      Icons.arrow_back,
                      color: themegreytextcolor,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<products_pro>(
        builder: ((context, modelValue, child) {
          return modelValue.productsIsLoading
              ? loadingShimmer(size)
              : modelValue.productName.isEmpty
                  ? Column(
                      children: [
                        Center(
                          child: Image.network(
                            "https://cdn2.iconfinder.com/data/icons/design-butterscotch-vol-2/256/Page_404-512.png",
                            height: 250,
                            width: 250,
                          ),
                        ),
                        const Text("No sub cateogry Products avaialable")
                      ],
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: modelValue.productName.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 320,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl:
                              getProductCardApi + modelValue.productCard[index],
                          imageBuilder: (context, imageProvider) =>
                              GestureDetector(
                            onTap: () {
                              RouteNavigator.route(
                                  context,
                                  ProductDetailsScreen(
                                    isProjectDetails: false,
                                    productUrl: modelValue.productUrl[index],
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: themewhitecolor,
                                boxShadow: [
                                  BoxShadow(
                                    color: themegreytextcolor.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              getProductCardApi +
                                                  modelValue.productCard[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    modelValue.productCategory[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: themeblackcolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: size.width / 100 * 20,
                                    child: Text(
                                      modelValue.productName[index],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: themegreytextcolor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rs.${(((int.parse(modelValue.productPrice[index]) / 100) * int.parse(modelValue.productDiscount[index]) - int.parse(modelValue.productPrice[index])).abs())}/-",
                                        style: const TextStyle(
                                          color: Palette.themecolor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: Palette.themecolor,
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: themegreycolor,
                            highlightColor: themegreytextcolor,
                            child: Container(
                              width: size.width,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: themegreycolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                    );
        }),
      ),
    );
  }

  Widget loadingShimmer(size) {
    return Shimmer.fromColors(
      baseColor: themegreycolor,
      highlightColor: themegreytextcolor,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: themegreycolor,
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: size.width / 100 * 75,
            height: 30.0,
            decoration: BoxDecoration(
              color: themegreycolor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
