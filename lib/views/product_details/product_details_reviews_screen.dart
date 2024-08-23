
import 'package:flutter/material.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class ProdcutDetailReviewsSheet extends StatefulWidget {
  
  
  const ProdcutDetailReviewsSheet({super.key,  });

  @override
  State<ProdcutDetailReviewsSheet> createState() => _ProdcutDetailReviewsSheetState();
}

class _ProdcutDetailReviewsSheetState extends State<ProdcutDetailReviewsSheet> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: SizedBox(
        height: size.height / 100 * 70,
        child: Scaffold(
          // backgroundColor: themewhitecolor,
         
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.themecolor.withOpacity(0.8),
                   Palette.themecolor.withOpacity(0.6),
                  Palette.themecolor.withOpacity(0.4),
                  Palette.themecolor.withOpacity(0.2),
                 
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.4, 0.8, 1],
              ),
            ),
            child: Center(
              child:  Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 25,
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                  ),
                                  child: Stack(
                                    children: [
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Reviews & Ratings",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            color: themewhitecolor,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CustomIconButton(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: themewhitecolor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  color: themewhitecolor,
                                ),
Consumer<products_pro>(builder: ((context, modelValue, child) {
  return  Expanded(
                                  child: SingleChildScrollView(
                                    child: ListView.separated(
                                      itemCount: modelValue.dProductReviewsUser.length,
                                      primary: false,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        // final model = snapshot.data![index];

                                        return 
                                        Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                "assets/images/png/ideas.png"),
                                          ),
                                          SizedBox(
                                            width: size.width / 100 * 2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:  [
                                              Text(
                                                modelValue.dProductReviewsUser[index],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: themewhitecolor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                               modelValue.dProductReviewsDescrip[index],
                                                style: const TextStyle(
                                                  fontSize: 14,
 color: themewhitecolor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                 modelValue.dProductReviewsDate[index],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: List.generate(
                                              int.parse(
                                                  modelValue.dProductReviewsRating[index]),
                                              (index) => const Icon(
                                                Icons.star,
                                                color: themeorangecolor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider(
                                          color: themewhitecolor,
                                        );
                                      },
                                    ),
                                  ),
                                );
                            
                            
}))
                               
                              ],
                            )
                   
            ),
          ),
        ),
      ),
    );
  }

 
}
