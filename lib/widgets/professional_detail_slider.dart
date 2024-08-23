import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/theme/colors.dart';

class ProfessionalDetailSlider extends StatefulWidget {
  final List items;
  final bool isEmptyy;
  
  String productTitle;
  String productDesc;
  

  ProfessionalDetailSlider(
      {
        required this.items,
        required this.isEmptyy,
      // required this.isMultiple,
      required this.productTitle,
      required this.productDesc,
      
      Key? key})
      : super(key: key);

  @override
  _ProfessionalDetailSliderState createState() => _ProfessionalDetailSliderState();
}

class _ProfessionalDetailSliderState extends State<ProfessionalDetailSlider> {
  
  String type = '';
  bool isFavorite = false;
  double containerSize = 30.0;
  @override
  Widget build(BuildContext context) {
    log("image: ${widget.isEmptyy}");
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            // color: Palette.themeColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: themewhitecolor,
            boxShadow: [
              BoxShadow(
                  color: themegreycolor, blurRadius: 5, offset: Offset(0, 10))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
             
              CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.3,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    
                  },
                ),
                items: List.generate(
               widget.isEmptyy? 1:
                  widget.items.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                         
                          
                         
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.isEmptyy? "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D": getServiceCardApi +widget.items[index],
                              height: size.height * 0.4,
                              width:size. width ,
                              placeholder: (context, url) => const Center(
                                  child: const CircularProgressIndicator(
                                color: themegreycolor,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16.0,
                              left: 16.0,
                              right: 16.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productTitle.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                   Text(
                                    widget.productDesc.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
       
      
      ],
    );
  }


}
