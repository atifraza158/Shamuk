import 'dart:developer';
import 'dart:math' as math;
import 'dart:io';

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';

class PropertyPdfViewScreen extends StatefulWidget {
  final String url;
  final String propertyAgency;
  const PropertyPdfViewScreen(
      {Key? key, required this.url, required this.propertyAgency})
      : super(key: key);

  @override
  State<PropertyPdfViewScreen> createState() => _Pdf_pervnState();
}

class _Pdf_pervnState extends State<PropertyPdfViewScreen> {
  late final String path;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    get_pdf();
  }

  bool _isLoading = true;
  changePDF(value) async {
    document = await PDFDocument.fromURL(Path);

    setState(() {
      _isLoading = false;
    });
  }

  String Path = "";
  void get_pdf() {
    setState(() {
      _isLoading = true;
    });
    Path = widget.url;
    print(Path);
    changePDF(0);
  }

  PDFDocument? document;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        title: const Text('View PDF'),
        actions: [
          IconButton(
              onPressed: () async {
                log("url: ${widget.url}");

                math.Random random = math.Random();
                int randomNumber = random.nextInt(99999);

                log("randomNumber: $randomNumber");
                final File? file = await FileDownloader.downloadFile(
                    url: widget.url,
                    name:
                        "/Shamuk/property/users/${widget.propertyAgency}/$randomNumber.pdf",

                    // name: "$randomNumber.pdf",
                    onProgress: (String? fileName, double progress) {
                      // setState(() => _progress = progress);
                    },
                    onDownloadCompleted: (String value) {
                      showMyCustomSnackBar(
                          "File downloaded Successfuly", false, context);
                    },
                    onDownloadError: (String error) {
                      log("onDownloadError: $error");

                      showMyCustomSnackBar("Download Failed", true, context);
                    });

                print('FILE: ${file?.path}');
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: _isLoading == true
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        radius: 25,
                        color: Palette.themecolor,
                      ),
                    )
                  : Path != ""
                      ? SizedBox(
                          height: height / 100 * 90,
                          child: PDFViewer(
                            indicatorBackground: Palette.themecolor,
                            document: document!,
                            zoomSteps: 1,
                            scrollDirection: Axis.vertical,
                            pickerButtonColor: Palette.themecolor,
                            lazyLoad: false,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.article_sharp,
                                  color: Colors.grey.shade300,
                                  size: MediaQuery.of(context).size.width / 3.5,
                                ),
                                Text(
                                  "Empty",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
