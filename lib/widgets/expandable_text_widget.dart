import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  ExpandableTextWidget(this.text, {super.key});

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget>
    with TickerProviderStateMixin<ExpandableTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
        
          duration: const Duration(milliseconds: 500),
          child: ConstrainedBox(
              constraints: widget.isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 50.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      widget.isExpanded
          ? ConstrainedBox(constraints: const BoxConstraints())
          : TextButton(
          child: const Text("read more"),
          onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}