import 'package:flutter/material.dart';
import 'package:flutterappdev/utilities/dailogs/generic_dailog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sharing",
    content: "You cannot share empty note",
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
