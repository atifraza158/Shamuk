import 'package:flutter/material.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/widgets/html_render.dart';

propertyDetailWidget(properties_pro modelValue) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: HtmlRenderCustom(
          text: modelValue.dPropertyDescription,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        // Text(
        //   modelValue.dPropertyDescription,
        //   textAlign: TextAlign.justify,
        //   style: const TextStyle(
        //     fontSize: 14,
        //   ),
        // ),
      ),
    ],
  );
}
