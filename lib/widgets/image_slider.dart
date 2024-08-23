// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:multivendor/theme/colors.dart';
// import 'package:multivendor/widgets/custom_icon_button.dart';

// class ActiveDot extends StatelessWidget {
//   const ActiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: themegreycolor,
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class InactiveDot extends StatelessWidget {
//   const InactiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class ImageSlider extends StatefulWidget {
//   final bool? isProjectDetails;
//   final String images;
//   const ImageSlider({
//     Key? key,
//     required this.images,
//     required this.isProjectDetails,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ImageSliderState createState() => _ImageSliderState();
// }

// class _ImageSliderState extends State<ImageSlider> {
//   int activeIndex = 0;

//   setActiveDot(index) {
//     setState(() {
//       activeIndex = index;
//     });
//   }

//   void favoriteselect(bool index) {
//     setState(() {
//       selectedindex = index;
//     });
//   }

//   bool? selectedindex;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       children: <Widget>[
//         CarouselSlider(
//           options: CarouselOptions(
//             enableInfiniteScroll: false,
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlay: false,
//             height: widget.isProjectDetails == true
//                 ? size.height / 100 * 25
//                 : size.height / 100 * 40,
//             autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//             autoPlayAnimationDuration: const Duration(seconds: 2),
//             viewportFraction: 1,
//             onPageChanged: (index, reason) {
//               setActiveDot(index);
//             },
//           ),
//           items: List.generate(
//             1,
//             (index) {
//               return Hero(
//                 tag: widget.images,
//                 child: Image.network(
//                   widget.images,
//                   colorBlendMode: BlendMode.modulate,
//                   color: themegreycolor,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               );
//             },
//           ),
//         ),
//         widget.isProjectDetails == true
//             ? Container()
//             : Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15, top: 15),
//                   child: CustomIconButton(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//               ),
//         widget.isProjectDetails == true
//             ? Positioned(
//                 bottom: 10,
//                 left: 20,
//                 right: 20,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: themeblackcolor.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.photo_size_select_actual,
//                             color: themewhitecolor,
//                             size: 20,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '${activeIndex + 1} of 1',
//                             style: const TextStyle(
//                               color: themewhitecolor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           selectedindex = false;
//                         });
//                       },
//                       child: selectedindex == true
//                           ? const Icon(
//                               Icons.favorite,
//                               color: Palette.themecolor,
//                               size: 35,
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   selectedindex = true;
//                                 });
//                               },
//                               child: const Icon(
//                                 Icons.favorite_border,
//                                 color: themewhitecolor,
//                                 size: 35,
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               )
//             : Positioned(
//                 bottom: 20,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     1,
//                     (idx) {
//                       return activeIndex == idx
//                           ? const ActiveDot()
//                           : const InactiveDot();
//                     },
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }
// }
