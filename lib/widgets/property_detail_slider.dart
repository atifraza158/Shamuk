import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/html_render.dart';
import 'package:video_player/video_player.dart';

class PropertyDetailSlider extends StatefulWidget {
  final List items;
  final bool isEmptyy;

  String productTitle;
  String productDesc;

  PropertyDetailSlider(
      {required this.items,
      required this.isEmptyy,
      // required this.isMultiple,
      required this.productTitle,
      required this.productDesc,
      Key? key})
      : super(key: key);

  @override
  _PropertyDetailSliderState createState() => _PropertyDetailSliderState();
}

class _PropertyDetailSliderState extends State<PropertyDetailSlider> {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 2),
                autoPlay: false,
                height: MediaQuery.of(context).size.height * 0.3,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                viewportFraction: 1,
                onPageChanged: (index, reason) {},
              ),
              items: List.generate(
                widget.isEmptyy ? 1 : widget.items.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        log("message");
                        if (widget.isEmptyy) {
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
                                      getPropertyCardApi + widget.items[index],
                                      height: 300,
                                      width: size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if ((widget.items[index]
                                .toString()
                                .split(".")[1]) ==
                            "mp4") {
                        } else {
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
                                  getPropertyDetailSliderCardApi +
                                                  widget.items[index],
                                      height: 300,
                                      width: size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Stack(
                          children: [
                            widget.isEmptyy
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: getPropertyCardApi +
                                          widget.items[index],
                                      height: size.height * 0.4,
                                      width: size.width,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          color: themegreycolor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  )
                                : (widget.items[index]
                                            .toString()
                                            .split(".")[1]) ==
                                        "mp4"
                                    ? PropertySliderVideo(
                                        videoUrl:
                                            getPropertyDetailSliderCardApi +
                                                widget.items[index])
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              getPropertyDetailSliderCardApi +
                                                  widget.items[index],
                                          height: size.height * 0.4,
                                          width: size.width,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(
                                              color: themegreycolor,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
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
                                  // Text(
                                  //   widget.productTitle.toString(),
                                  //   overflow: TextOverflow.ellipsis,
                                  //   maxLines: 1,
                                  // style: const TextStyle(
                                  //   color: Colors.white,
                                  //   fontSize: 18.0,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                  // ),
                                  HtmlRenderCustom(
                                    text: widget.productTitle.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // const SizedBox(height: 4.0),
                                  // HtmlRenderCustom(
                                  //   text: widget.productDesc.toString(),
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 14.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   widget.productDesc.toString(),
                                  //   overflow: TextOverflow.ellipsis,
                                  //   maxLines: 1,
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 14.0,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PropertySliderVideo extends StatefulWidget {
  final String videoUrl;

  const PropertySliderVideo({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<PropertySliderVideo> createState() => _PropertySliderVideoState();
}

class _PropertySliderVideoState extends State<PropertySliderVideo> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    );

    videoPlayerController.addListener(() {
      setState(() {});
    });
    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((_) => setState(() {}));
    videoPlayerController.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("widget.videoUrl: ${widget.videoUrl}");
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: themeblackcolor,
      ),
      child: videoPlayerController.value.isInitialized
          ? VideoPlayer(
              videoPlayerController,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
