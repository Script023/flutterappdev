import 'package:flutter/material.dart';
import 'package:flutterappdev/utilities/dailogs/generic_dailog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: "Are you sure you want to delete this note?",
    optionsBuilder: () => {'Cancel': false, 'Yes': true},
  ).then((value) => value ?? false);
}
