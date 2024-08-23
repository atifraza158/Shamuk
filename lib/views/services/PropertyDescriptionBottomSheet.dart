import 'package:flutter/material.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';


class ProfessionalReviewsBottomSheet extends StatefulWidget {
  String propertyTitle;
  String propertyDescription;
  services_pro modelValue;

  ProfessionalReviewsBottomSheet(
      {Key? key,
      required this.propertyTitle,
      required this.propertyDescription,
      required this.modelValue,
      
      })
      : super(key: key);

  @override
  State<ProfessionalReviewsBottomSheet> createState() =>
      _ProfessionalReviewsBottomSheetState();
}

class _ProfessionalReviewsBottomSheetState
    extends State<ProfessionalReviewsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.transparent),
          backgroundColor:Palette.themecolor,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Ratings & Reviews",
            style: const TextStyle(color: themewhitecolor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
              child: Container(
                decoration: const BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: themegreycolor,
                    ),
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(5)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: 
            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                  widget.modelValue.dProfReviewsUser.length, (index) {
                                return Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: themegreycolor,
                                        blurRadius: 5.0,
                                        offset: Offset(1, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 28,
                                                backgroundColor:
                                                    Palette.themecolor,
                                                backgroundImage: AssetImage(
                                                    "assets/images/png/projects.png"),
                                              ),
                                              SizedBox(
                                                  width: size.width / 100 * 2),
                                              Text(
                                              widget.  modelValue
                                                    .dProfReviewsUser[index],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: List.generate(
                                              int.parse(widget.modelValue
                                                  .dProfReviewsRating[index]),
                                              (index) => const Icon(
                                                Icons.star,
                                                color: themeorangecolor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 3),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.verified_rounded,
                                              size: 20,
                                              color: Palette.themecolor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Verified Buyer",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                           widget. modelValue
                                                .dProfReviewsReview[index],
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                           widget. modelValue.dProfReviewsDate[index],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              }),
                            ),
            
           
          ),
        ),
      ),
    );
  }
}
