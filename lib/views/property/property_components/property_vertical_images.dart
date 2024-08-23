import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:video_player/video_player.dart';

import 'image_view.dart';
// import 'package:widget_zoom/widget_zoom.dart';

// ignore: must_be_immutable
class PropertyVerticalImages extends StatefulWidget {
  final List items;
  final bool isEmptyy;

  String productTitle;
  String productDesc;

  PropertyVerticalImages(
      {required this.items,
      required this.isEmptyy,
      // required this.isMultiple,
      required this.productTitle,
      required this.productDesc,
      Key? key})
      : super(key: key);

  @override
  _PropertyVerticalImagesState createState() => _PropertyVerticalImagesState();
}

class _PropertyVerticalImagesState extends State<PropertyVerticalImages> {
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: themewhitecolor,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: List.generate(
                    widget.isEmptyy ? 1 : widget.items.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              widget.isEmptyy
                                  ? GestureDetector(
                                      onTap: () {
                                        print("image Data: " +
                                            getPropertyCardApi +
                                            widget.items[index]);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ImageView(
                                              imageURL: getPropertyCardApi +
                                                  widget.items[index],
                                            );
                                          },
                                        ));
                                      },
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: getPropertyCardApi +
                                            widget.items[index],
                                        height: size.height * 0.4,
                                        width: size.width,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    const CircularProgressIndicator(
                                          color: themeredcolor,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )
                                  : (widget.items[index]
                                              .toString()
                                              .split(".")[1]) ==
                                          "mp4"
                                      ?
                                      // WidgetZoom(
                                      // heroAnimationTag: 'tag',
                                      // zoomWidget:
                                      PropertySliderVideo(
                                          videoUrl:
                                              getPropertyDetailSliderCardApi +
                                                  widget.items[index])
                                      // )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ImageView(
                                                  imageURL: getPropertyCardApi +
                                                      widget.items[index],
                                                );
                                              },
                                            ));
                                          },
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                getPropertyDetailSliderCardApi +
                                                    widget.items[index],
                                            height: size.height * 0.4,
                                            width: size.width,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  const CircularProgressIndicator(
                                                color: themegreycolor,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 140)
              ],
            ),
          ),
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
