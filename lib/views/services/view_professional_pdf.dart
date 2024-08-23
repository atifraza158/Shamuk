import 'dart:developer';

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class ViewProfessionalPdfViewScreen extends StatefulWidget {
  final String url;
  const ViewProfessionalPdfViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<ViewProfessionalPdfViewScreen> createState() => _Pdf_pervnState();
}

class _Pdf_pervnState extends State<ViewProfessionalPdfViewScreen> {
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
    log("url: ${widget.url}");
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        title: const Text('View PDF'),
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
                          height: size.height / 100 * 90,
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
