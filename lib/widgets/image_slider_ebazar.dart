import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: Palette.themecolor,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  const InactiveDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final double viewportFraction;
  final double height;
  final double leftMargin;
  final double rightMargin;
  final bool enlargeCenterPage;
  final bool isShowIndicator;
  final List images;
  final bool autoPlay;
  final double borderRadius;
  final bool isVideo;
  final bool isNetworkImage;
  final bool enableInfiniteScroll;
  final String videoLink;
  final bool useShadow;
  final bool? isEmpty;
  const ImageSlider({
    Key? key,
    this.viewportFraction = 1,
    this.height = 200,
    this.leftMargin = 20,
    this.rightMargin = 20,
    this.enlargeCenterPage = false,
    this.isShowIndicator = true,
    this.images = const [],
    this.autoPlay = true,
    this.borderRadius = 12,
    this.isVideo = false,
    this.isNetworkImage = false,
    this.enableInfiniteScroll = true,
    this.videoLink = '',
    this.useShadow = true,
    this.isEmpty = true,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late Animation<double> scaleAnimation;
  late AnimationController animationController;
  // late VideoPlayerController _videoController;
  bool isVideoPause = true;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // _videoController = VideoPlayerController.network(
    //   widget.videoLink,
    // );
    scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
        reverseCurve: Curves.ease,
      ),
    );
    // _videoController.addListener(() {
    //   setState(() {});
    // });

    // _videoController.setLooping(true);
    // _videoController.initialize().then((_) => setState(() {}));
    // _videoController.pause();
    animationController.forward();
  }

  @override
  void dispose() {
    // _videoController.dispose();
    super.dispose();
  }

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 5),
            autoPlay: widget.autoPlay,
            height: widget.height,
            enlargeCenterPage: widget.enlargeCenterPage,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            viewportFraction: widget.viewportFraction,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            onPageChanged: (index, reason) {
              setActiveDot(index);
            },
          ),
          items: List.generate(
            widget.isEmpty == true ? 1 : widget.images.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  if (widget.isEmpty == false) {
                    RouteNavigator.route(
                      context,
                      SafeArea(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomIconButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: themewhitecolor,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: themeblackcolor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.network(
                               getProductDetailSliderCardApi +  widget.images[index],
                                // height: 300,
                                width: size.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: widget.leftMargin,
                    right: widget.rightMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    image: widget.isVideo
                        ? null
                        : DecorationImage(
                            image: widget.isNetworkImage
                                ? widget.isEmpty == true
                                    ? AssetImage(
                                        "assets/images/png/image-not-fouud-p.png",
                                      )
                                    : NetworkImage(
                                        getProductDetailSliderCardApi +
                                            widget.images[index],
                                      ) as ImageProvider
                                : AssetImage(
                                    widget.images[index],
                                  ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      gradient: widget.useShadow
                          ? LinearGradient(
                              colors: [
                                themeblackcolor.withOpacity(0.1),
                                themeblackcolor.withOpacity(0.2),
                                themeblackcolor.withOpacity(0.3),
                                themeblackcolor.withOpacity(0.8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                    ),
                    // child: widget.isVideo
                    //     ? InkWell(
                    //         onTap: () {
                    //           // playVideo();
                    //           setState(() {
                    //             if (_videoController.value.isPlaying) {
                    //               setState(() {
                    //                 isVideoPause = true;
                    //               });
                    //               _videoController.pause();
                    //               animationController.forward().then(
                    //                     (value) => Timer(
                    //                       const Duration(milliseconds: 300),
                    //                       () {
                    //                         // setState(() {
                    //                         //   isVideoPause = false;
                    //                         // });
                    //                       },
                    //                     ),
                    //                   );
                    //             } else {
                    //               setState(() {
                    //                 isVideoPause = true;
                    //               });
                    //               _videoController.play();
                    //               animationController.reverse().then(
                    //                     (value) => Timer(
                    //                       const Duration(milliseconds: 300),
                    //                       () {
                    //                         setState(() {
                    //                           isVideoPause = false;
                    //                         });
                    //                       },
                    //                     ),
                    //                   );
                    //             }
                    //           });
                    //         },
                    //         child: Stack(
                    //           children: [
                    //             Container(
                    //               height: 275,
                    //               foregroundDecoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.only(
                    //                   topLeft:
                    //                       Radius.circular(widget.borderRadius),
                    //                   topRight:
                    //                       Radius.circular(widget.borderRadius),
                    //                 ),
                    //                 gradient: LinearGradient(
                    //                   colors: [
                    //                     themeblackcolor.withOpacity(0.3),
                    //                     themeblackcolor.withOpacity(0.4),
                    //                     themeblackcolor.withOpacity(0.5),
                    //                     themeblackcolor.withOpacity(0.8),
                    //                   ],
                    //                   begin: Alignment.topCenter,
                    //                   end: Alignment.bottomCenter,
                    //                 ),
                    //               ),
                    //               child: VideoPlayer(_videoController),
                    //             ),
                    //             Visibility(
                    //               visible: isVideoPause,
                    //               child: ScaleTransition(
                    //                 scale: scaleAnimation,
                    //                 alignment: Alignment.center,
                    //                 child: Align(
                    //                   alignment: Alignment.center,
                    //                   child: CircleAvatar(
                    //                     radius: 35,
                    //                     backgroundColor:
                    //                         themeblackcolor.withOpacity(0.5),
                    //                     child: Icon(
                    //                       _videoController.value.isPlaying
                    //                           ? Icons.pause
                    //                           : Icons.play_arrow,
                    //                       color: themewhitecolor,
                    //                       size: 30,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     : Container(),
                  ),
                ),
              );
            },
          ),
        ),
        widget.isShowIndicator == true
            ? Positioned(
                bottom: -20,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (idx) {
                      return activeIndex == idx
                          ? const ActiveDot()
                          : const InactiveDot();
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
