import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/category_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/product_details/product_details_screen.dart';
import 'package:multivendor/widgets/shimmers/maincategoryproduct_loading_widget.dart';
import 'package:multivendor/widgets/shimmers/subcategoryname_loading_widget.dart';
import 'package:multivendor/widgets/shimmers/subcategoryproduct_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class SubCategoryAndProductsScreen extends StatefulWidget {
  final String catergoryId;
  final String categoryName;
  const SubCategoryAndProductsScreen(
      {Key? key, required this.catergoryId, required this.categoryName})
      : super(key: key);

  @override
  State<SubCategoryAndProductsScreen> createState() =>
      _SubCategoryAndProductsScreenState();
}

class _SubCategoryAndProductsScreenState
    extends State<SubCategoryAndProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    final subCategoryProvider =
        Provider.of<category_pro>(context, listen: false);
    subCategoryProvider.getShopSubCategoriesByIdFunc(
        widget.catergoryId, context);
    log("widget.catergoryId ${widget.catergoryId}");
    final productProvider = Provider.of<products_pro>(context, listen: false);
    productProvider.getProducts(
        "", widget.catergoryId, "", "", "", "", "", context);
    super.initState();
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
// Center(
//                               child: Image.asset(
//                                 "assets/images/png/no_subcategory_product.png",
//                                 height: 250,
//                                 width: 250,
//                               ),
//                             );
    return Scaffold(
        backgroundColor: themewhitecolor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //sub categories names
              Consumer<category_pro>(
                builder: ((context, modelValue, child) {
                  return modelValue.subCategoriesIsLoading
                      ? const SubCategoriesNameLoadingWidget()
                      : modelValue.subCategoryName.isEmpty
                          ? Center(
                              child: Image.asset(
                                "assets/images/png/no_subcategory_product.png",
                                height: 250,
                                width: 250,
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  modelValue.subCategoryName.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });

                                        final subcategoryProductProvider =
                                            Provider.of<products_pro>(context,
                                                listen: false);
                                        subcategoryProductProvider
                                            .getSubCategoryProducts(
                                                "",
                                                widget.catergoryId,
                                                modelValue.subCategoryId[index],
                                                "",
                                                "",
                                                "",
                                                "",
                                                context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 10,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                modelValue
                                                    .subCategoryName[index],
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              selectedIndex == index
                                                  ? Container(
                                                      height: 4,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            Palette.themecolor,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                }),
              ),
              //sub categories product column
              (selectedIndex == null)
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text.rich(
                            TextSpan(
                              text: "Sub Category ",
                              style: TextStyle(
                                color: themeblackcolor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "Products",
                                  style: TextStyle(
                                    color: Palette.themecolor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer<products_pro>(
                          builder: ((context, modelValue, child) {
                            return modelValue.subcategoryProductsIsLoading
                                ? const SubCategoriesProductLoadingWidget()
                                : modelValue.subcategoryProductName.isEmpty
                                    ? Center(
                                        child: Image.asset(
                                          "assets/images/png/no_subcategory_product.png",
                                          height: 250,
                                          width: 250,
                                        ),
                                      )
                                    : GridView.builder(
                                        padding: const EdgeInsets.all(20),
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: modelValue
                                            .subcategoryProductName.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 320,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                        ),
                                        itemBuilder: (context, index) {
                                          return CachedNetworkImage(
                                            imageUrl: getProductCardApi +
                                                modelValue
                                                        .subcategoryProductCard[
                                                    index],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    GestureDetector(
                                              onTap: () {
                                                RouteNavigator.route(
                                                  context,
                                                  ProductDetailsScreen(
                                                    isProjectDetails: false,
                                                    productUrl: modelValue
                                                            .subcategoryProductUrl[
                                                        index],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: themewhitecolor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: themegreytextcolor
                                                          .withOpacity(0.5),
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 200,
                                                          width: size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                getProductCardApi +
                                                                    modelValue
                                                                            .subcategoryProductCard[
                                                                        index],
                                                                // "https://freepngimg.com/thumb/sofa/10-2-sofa-free-png-image.png"
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
                                                      modelValue
                                                              .subcategoryProductCategory[
                                                          index],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: themeblackcolor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          size.width / 100 * 20,
                                                      child: Text(
                                                        modelValue
                                                                .subcategoryProductName[
                                                            index],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color:
                                                              themegreytextcolor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Rs.${(((int.parse(modelValue.subcategoryProductPrice[index]) / 100) * int.parse(modelValue.subcategoryProductDiscount[index]) - int.parse(modelValue.subcategoryProductPrice[index])).abs())}/-",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Ubuntu-Bold',
                                                            fontSize: 18,
                                                            color: Palette
                                                                .themecolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .add,
                                                          color: Palette
                                                              .themecolor,
                                                          size: 35,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: themegreycolor,
                                              highlightColor:
                                                  themegreytextcolor,
                                              child: Container(
                                                width: size.width,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  color: themegreycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          );
                                        },
                                      );
                          }),
                        ),
                      ],
                    ),
//main category products
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text.rich(
                      TextSpan(
                        text: "${widget.categoryName} ",
                        style: const TextStyle(
                          color: themeblackcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: const [
                          TextSpan(
                            text: "Products",
                            style: TextStyle(
                              color: Palette.themecolor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<products_pro>(
                    builder: ((context, modelValue, child) {
                      return modelValue.productsIsLoading
                          ? const MainCategoriesProductLoadingWidget()
                          : modelValue.productName.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/png/empty_box.png",
                                        height: 250,
                                        width: 250,
                                      ),
                                    ),
                                    const Text(
                                      "No Products availables",
                                      style: TextStyle(
                                        color: themeblackcolor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
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
                                    mainAxisExtent: 257,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                  ),
                                  itemBuilder: (context, index) {
                                    return CachedNetworkImage(
                                      imageUrl: getProductCardApi +
                                          modelValue.productCard[index],
                                      imageBuilder: (context, imageProvider) =>
                                          GestureDetector(
                                        onTap: () {
                                          RouteNavigator.route(
                                              context,
                                              ProductDetailsScreen(
                                                isProjectDetails: false,
                                                productUrl: modelValue
                                                    .productUrl[index],
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: themewhitecolor,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: themegreycolor,
                                                blurRadius: 10,
                                                offset: Offset(5, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    width: size.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          getProductCardApi +
                                                              modelValue
                                                                      .productCard[
                                                                  index],
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      modelValue
                                                              .productCategory[
                                                          index],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: themeblackcolor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          size.width / 100 * 20,
                                                      child: Text(
                                                        modelValue
                                                            .productName[index],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color:
                                                              themegreytextcolor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Rs.${(((int.parse(modelValue.productPrice[index]) / 100) * int.parse(modelValue.productDiscount[index]) - int.parse(modelValue.productPrice[index])).abs())}/-",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Ubuntu-Bold',
                                                            fontSize: 18,
                                                            color: Palette
                                                                .themecolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .add,
                                                          color: Palette
                                                              .themecolor,
                                                          size: 35,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: themegreycolor,
                                        highlightColor: themegreytextcolor,
                                        child: Container(
                                          width: size.width,
                                          height: 150.0,
                                          decoration: BoxDecoration(
                                            color: themegreycolor,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                ],
              ),
            ],
          ),
        ));
  }
}
