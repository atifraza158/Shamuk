import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

// ignore: must_be_immutable
class HtmlRenderCustom extends StatelessWidget {
  final String text;
  TextStyle style;
  HtmlRenderCustom(
      {super.key, required this.text, this.style = const TextStyle()});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      '''$text''',
      renderMode: RenderMode.column,
      textStyle: style,
    );
  }
}
