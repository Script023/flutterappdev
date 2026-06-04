import 'package:flutter/material.dart';
import 'package:flutterappdev/utilities/dailogs/generic_dailog.dart';

Future<void> showErrorDialog(
  BuildContext context, 
  String text,
  ) {
    return showGenericDialog(
      context: context,
      title: "An error occurred",
      content: text,
      optionsBuilder: () => {
        "OK": null,
      },
    );
  }